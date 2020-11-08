class PurchasesController < ApplicationController
  before_action :set_item, only: [:index, :create]

  def index
    @purchase_shipping_address = PurchaseShippingAddress.new
  end

  def create
    binding.pry
    @purchase_shipping_address = PurchaseShippingAddress.new(purchase_shipping_address_params)
    if @purchase_shipping_address.valid?
      @purchase_shipping_address.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def purchase_shipping_address_params
    params.require(:purchase_shipping_address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end
end
