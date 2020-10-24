FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.name}
    email                 {Faker::Internet.free_email}
    password              {"a1a1a1"}
    password_confirmation {password}
    family_name           {"全角"}
    first_name            {"全角"}
    family_name_reading   {"カナ"}
    first_name_reading    {"カナ"}
    birthday              {Faker::Date.between(from: '1930-01-01', to: '2015-12-31')}
  end
end