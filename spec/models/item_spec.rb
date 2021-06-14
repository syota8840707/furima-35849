require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品出品情報データ' do
    context '出品できる場合' do
      it '画像、商品名、商品説明、カテゴリー、商品の状態、配送料の負担、配送元の地域、配送までの日数、価格、があれば出品できる' do
        expect(@item).to be_valid
      end
      it '価格が半角数字のみなら出品できる' do
        @item.price = '400000'
        expect(@item).to be_valid
      end
      it '価格は¥300~¥9,999,999の間のみなら出品できる' do
        @item.price = '300'
        @item.price = '9999999'
        expect(@item).to be_valid
      end
    end
    context '出品出来ない場合' do
      it '画像がなければ出品出来ない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が無ければ出品出来ない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it '商品説明がなければ出品出来ない' do
        @item.info = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Info can't be blank")
      end
      it 'カテゴリーがなければ出品出来ない' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Category のセレクタから選択して下さい')
      end
      it 'カテゴリーのid1が選択されると出品出来ない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('Category のセレクタから選択して下さい')
      end
      it '商品の状態がなければ出品出来ない' do
        @item.sales_status_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Sales status のセレクタから選択して下さい')
      end
      it '出品の状態のid1が選択されると出品出来ない' do
        @item.sales_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Sales status のセレクタから選択して下さい')
      end
      it '配送料の負担がなければ出品出来ない' do
        @item.shipping_fee_status_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping fee status のセレクタから選択して下さい')
      end
      it '配送料の負担のid1が選択されると出品出来ない' do
        @item.shipping_fee_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping fee status のセレクタから選択して下さい')
      end
      it '配送地域がなければ出品出来ない' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture のセレクタから選択して下さい')
      end
      it '配送地域のid1が選択されると出品出来ない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture のセレクタから選択して下さい')
      end
      it '配送までの日数がなければ出品出来ない' do
        @item.scheduled_delivery_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Scheduled delivery のセレクタから選択して下さい')
      end
      it '配送までの日数のid1が選択されると出品出来ない' do
        @item.scheduled_delivery_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Scheduled delivery のセレクタから選択して下さい')
      end

      it '価格が無ければ出品出来ない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'userが紐付いていないと出品できないこと' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
      it '価格が全角数字だと出品出来ない' do
        @item.price = '３３３３３３'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it '価格が半角英字だと出品出来ない' do
        @item.price = 'rrxxxvv'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it '価格が半角英数字混合だと出品出来ない' do
        @item.price = '345fffd'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it '価格は300円以下の場合は出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end
      it '価格は10000000円以上の場合は出品できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end
    end
  end
end
