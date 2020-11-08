FactoryBot.define do
  factory :purchase_shipping_address do
    postal_code   { '000-0000' }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city          { '東京都' }
    house_number  { '1-1' }
    building_name { '東京ハイツ' }
    phone_number  { '00000000000' }
    token         { "tok_abcdefghijk00000000000000000" }
    user_id       { '1' }
    item_id       { '1' }
  end
end
