class PurchaseShippingAddress

  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/, message: 'Input correctly' }
    validates :prefecture_id, numericality: { other_than: 1, message: 'select' }
    validates :city
    validates :house_number
    validates :phone_number, format: { with: /\A\d+\z/, message: 'Input only number'}, length: { maximum: 11 }
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    shipping_address = ShippingAddress.new(postal_code: postal_code, prefecture_id: prefecture_id, house_number: house_number, building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)
  end
end