# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "json"

orders_data = JSON.parse(
  File.read(Rails.root.join("data/orders.json"))
)

orders_data.each do |order_data|
  order = Order.create!(
    external_id: order_data["id"],
    state: order_data["state"],
    ordered_at: order_data["createdAt"],
    promotion_codes: order_data["promotionCodes"],
    discount_code: order_data["discountCode"]
  )

  order_data["items"].each do |item|
    order.order_items.create!(
      name: item["name"],
      size: item["size"],
      add_ingredients: item["add"],
      remove_ingredients: item["remove"]
    )
  end
end
