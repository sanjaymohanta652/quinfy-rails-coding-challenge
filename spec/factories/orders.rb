FactoryBot.define do
  factory :order do
    external_id { "MyString" }
    state { "MyString" }
    promotion_codes { "MyText" }
    discount_code { "MyString" }
    ordered_at { "2026-05-07 22:59:23" }
    total_price { "9.99" }
  end
end
