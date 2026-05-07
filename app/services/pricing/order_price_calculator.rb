class Pricing::OrderPriceCalculator
    def initialize(order)
      @order = order
      @config = YAML.load_file(Rails.root.join("data/config.yml"))
    end

    def call
      total = calculate_items_total
      total -= promotion_discount
      total = apply_discount(total)

      total.round(2)
    end

    private

    attr_reader :order, :config

    def calculate_items_total
      order.order_items.sum do |item|
        calculate_item_price(item)
      end
    end

    def calculate_item_price(item)
      base_price = pizza_base_price(item)
      ingredient_price = extra_ingredients_price(item)

      (base_price + ingredient_price) * size_multiplier(item)
    end

    def pizza_base_price(item)
      config["pizzas"][item.name]
    end

    def extra_ingredients_price(item)
      item.add_ingredients.sum do |ingredient|
        config["ingredients"][ingredient]
      end
    end

    def size_multiplier(item)
      config["size_multipliers"][item.size]
    end

    def apply_discount(total)
      return total unless order.discount_code.present?

      discount =
        config["discounts"][order.discount_code]["deduction_in_percent"]

      total - (total * discount / 100.0)
    end

    def promotion_discount
        return 0 if order.promotion_codes.blank?

        order.promotion_codes.sum do |code|
          calculate_promotion_discount(code)
        end
    end

    def calculate_promotion_discount(code)
        promotion = config["promotions"][code]

        return 0 unless promotion

        eligible_items = order.order_items.select do |item|
          item.name == promotion["target"] &&
            item.size == promotion["target_size"]
        end

        eligible_count = eligible_items.count

        free_items_count =
          (eligible_count / promotion["from"]) *
            (promotion["from"] - promotion["to"])

        eligible_items
          .first(free_items_count)
          .sum { |item| pizza_base_price(item) * size_multiplier(item) }
    end
end
