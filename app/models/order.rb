class Order < ApplicationRecord
    has_many :order_items, dependent: :destroy
    serialize :promotion_codes, coder: JSON
    validates :external_id, presence: true, uniqueness: true
    validates :state, presence: true

    def calculated_total_price
        Pricing::OrderPriceCalculator.new(self).call
    end
end
