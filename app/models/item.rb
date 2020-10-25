class Item < ApplicationRecord

  belongs_to :user
  has_one_attached :image

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
end
