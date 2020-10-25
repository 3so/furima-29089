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
    validates :name
    validates :description
    validates :category_id
    validates :condition_id
    validates :shipping_charges_payer_id
    validates :shipping_location_id
    validates :lead_time_id
    validates :price, :numericality => { :greater_than_or_equal_to => 300, :less_than_or_equal_to => 9999999}
    validates :image
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :condition_id
    validates :shipping_charges_payer_id
    validates :shipping_location_id
    validates :lead_time_id
  end
end
