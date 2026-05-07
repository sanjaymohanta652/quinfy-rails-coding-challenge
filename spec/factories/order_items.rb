FactoryBot.define do
  factory :order_item do
    order { nil }
    name { "MyString" }
    size { "MyString" }
    add_ingredients { "MyText" }
    remove_ingredients { "MyText" }
  end
end
