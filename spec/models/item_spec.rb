require 'rails_helper'

describe Item do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能の実装' do
    context '製品情報の登録' do
      it '製品画像、商品名、商品の説明、カテゴリーの情報、商品の状態、配送料の負担、配送元の住所、発送までの日数、価格があれば登録できること' do
        expect(@item).to be_valid
      end
      it '画像は1枚必須であること' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が必須であること' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it '商品の説明が必須であること' do
        @item.description = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'カテゴリーの情報が必須であること' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it '商品の状態についての情報が必須であること' do
        @item.condition_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it '配送料の負担についての情報が必須であること' do
        @item.shipping_charges_payer_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping charges payer can't be blank")
      end
      it '配送元の住所についての情報が必須であること' do
        @item.shipping_location_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping location can't be blank")
      end
      it '発送までの日数についての情報が必須であること' do
        @item.lead_time_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Lead time can't be blank")
      end
      it '価格についての情報が必須であること' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '価格が300円未満ではないこと' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price out of setting range')
      end
      it '価格が9,999,999円以上ではないこと' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price out of setting range')
      end
      it '価格は半角数字で入力されていること' do
        @item.price = 'hoge'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price half-width number')
      end
    end

    context 'ActiveHashのバリデーションについて' do
      it 'category_id = 1 ではないこと' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category select')
      end
      it 'condition_id = 1 ではないこと' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition select')
      end
      it 'shipping_charges_payer_id = 1 ではないこと' do
        @item.shipping_charges_payer_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping charges payer select')
      end
      it 'shipping_location_id = 1 ではないこと' do
        @item.shipping_location_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping location select')
      end
      it 'lead_time_id = 1 ではないこと' do
        @item.lead_time_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Lead time select')
      end
    end

    context 'エラーハンドリングについて' do
      it 'エラーハンドリングができていること' do
        @item.image = nil
        @item.valid?
        expect do
          @item.save
        end.not_to change { Item.count }
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
    end
  end
end
