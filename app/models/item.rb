class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user

  has_one_attached :image
  
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_charges_payer
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :lead_time

  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :price,
              format: { with: /\A[0-9]+\z/, message: "half-width number" },
              numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "out of setting range"}
    validates :category_id
    validates :condition_id
    validates :shipping_charges_payer_id
    validates :shipping_location_id
    validates :lead_time_id
  end
   
  with_options numericality: { other_than: 1, message: "select" } do
    validates :category_id
    validates :condition_id
    validates :shipping_charges_payer_id
    validates :shipping_location_id
    validates :lead_time_id
  end

end
