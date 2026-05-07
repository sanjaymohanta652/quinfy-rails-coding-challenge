require "rails_helper"

RSpec.describe Pricing::OrderPriceCalculator do
  describe "#call" do
    let(:order) do
      Order.create!(
        external_id: SecureRandom.uuid,
        state: "OPEN",
        promotion_codes: promotion_codes,
        discount_code: discount_code,
        ordered_at: Time.current
      )
    end

    let(:promotion_codes) { [] }
    let(:discount_code) { nil }

    context "when calculating a simple pizza price" do
      before do
        order.order_items.create!(
          name: "Tonno",
          size: "Large",
          add_ingredients: [],
          remove_ingredients: []
        )
      end

      it "calculates the correct total price" do
        result = described_class.new(order).call

        expect(result).to eq(10.4)
      end
    end

    context "when applying extra ingredients" do
      before do
        order.order_items.create!(
          name: "Margherita",
          size: "Large",
          add_ingredients: [ "Cheese" ],
          remove_ingredients: []
        )
      end

      it "includes ingredient prices" do
        result = described_class.new(order).call

        expect(result).to eq(9.1)
      end
    end

    context "when applying promotion codes" do
      let(:promotion_codes) { [ "2FOR1" ] }

      before do
        2.times do
          order.order_items.create!(
            name: "Salami",
            size: "Small",
            add_ingredients: [],
            remove_ingredients: []
          )
        end
      end

      it "applies promotion discount correctly" do
        result = described_class.new(order).call

        expect(result).to eq(4.2)
      end
    end

    context "when applying discount codes" do
      let(:discount_code) { "SAVE5" }

      before do
        order.order_items.create!(
          name: "Tonno",
          size: "Large",
          add_ingredients: [],
          remove_ingredients: []
        )
      end

      it "applies percentage discount correctly" do
        result = described_class.new(order).call

        expect(result).to eq(9.88)
      end
    end
  end
end
