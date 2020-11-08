require 'rails_helper'

describe PurchaseShippingAddress do
  before do
    @purchase_shipping_address = FactoryBot.build(:purchase_shipping_address)
  end

  describe '商品購入機能の実装' do

    context 'クレジットカード決済機能' do

      it '正しいtokenが存在すれば決済できること' do
        expect(@purchase_shipping_address).to be_valid
      end
      it 'tokenがなければ決済できないこと' do
        @purchase_shipping_address.token = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Token can't be blank")
      end
    end

    context '配送先情報の保存' do

      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_shipping_address).to be_valid
      end
      it '郵便番号が必須であること' do
        @purchase_shipping_address.postal_code = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号にはハイフンが必要であること' do
        @purchase_shipping_address.postal_code = "0000000"
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Postal code Input correctly")
      end
      it '都道府県が必須であること' do
        @purchase_shipping_address.prefecture_id = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'prefecture_idが1ではないこと' do
        @purchase_shipping_address.prefecture_id = 1
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Prefecture select")
      end
      it '市区町村が必須であること' do
        @purchase_shipping_address.city = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("City can't be blank")
      end
      it '番地が必須であること' do
        @purchase_shipping_address.house_number = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("House number can't be blank")
      end
      it '建物番号がなくても問題ないこと' do
        @purchase_shipping_address.building_name = nil
        expect(@purchase_shipping_address).to be_valid
      end
      it '電話番号が必須であること' do
        @purchase_shipping_address.phone_number = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号にはハイフンは不要であること' do
        @purchase_shipping_address.phone_number = "000-000-0000"
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Phone number Input only number")
      end
      it '電話番号は11桁以内であること' do
        @purchase_shipping_address.phone_number = "000000000000"
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Phone number is too long (maximum is 11 characters)")
      end
      it 'エラーハンドリングができていること' do
        @purchase_shipping_address.postal_code = nil
        @purchase_shipping_address.valid?
        expect{@purchase_shipping_address.save}.not_to change{
          [Purchase.count, ShippingAddress.count] 
        }
      end
    end
  end
end