class Item < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :description
    validates :category_id
    validates :condition_id
    validates :shipping_charges_payer_id
    validates :shipping_location_id
    validates :lead_time_id
    validates :price
    validates :user_id, foreign_key: true
  end
end
