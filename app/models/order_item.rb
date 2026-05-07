class OrderItem < ApplicationRecord
  belongs_to :order
  serialize :add_ingredients, coder: JSON
  serialize :remove_ingredients, coder: JSON

  validates :name, presence: true
  validates :size, presence: true
end
