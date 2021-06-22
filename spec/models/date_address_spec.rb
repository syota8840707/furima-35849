require 'rails_helper'

RSpec.describe DateAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @date_address = FactoryBot.build(:date_address, user_id: user.id, item_id: item.id)
    sleep 0.1
  end

  describe '購入情報の保存' do
    context '購入できる時' do
      it '全ての値が正しく入力されていれば購入できる' do
        expect(@date_address).to be_valid
      end
      it '建物名は空でも購入できること' do
        @date_address.bilding = ''
        expect(@date_address).to be_valid
      end
    end

    context '購入できない時' do
      it '郵便番号がないと購入出来ない' do
        @date_address.postal_code = ''
        @date_address.valid?
        expect(@date_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号は、「3桁ハイフン4桁」以外のの半角文字列では購入出来ない' do
        @date_address.postal_code = '3333-555'
        @date_address.valid?
        expect(@date_address.errors.full_messages).to include('Postal code input correctly')
      end
      it '郵便番号は、「3桁ハイフン4桁」の全角文字列では購入出来ない' do
        @date_address.postal_code = '４４４-４４４４'
        @date_address.valid?
        expect(@date_address.errors.full_messages).to include('Postal code input correctly')
      end
      it '郵便番号は、ハイフンがないと購入出来ない' do
        @date_address.postal_code = '3334444'
        @date_address.valid?
        expect(@date_address.errors.full_messages).to include('Postal code input correctly')
      end
      it '都道府県がないと購入出来ない' do
        @date_address.prefecture_id = ''
        @date_address.valid?
        expect(@date_address.errors.full_messages).to include("Prefecture can't be blank", 'Prefecture のセレクタから選択して下さい')
      end
      it '都道府県セレクト（１）を選択すると購入出来ない' do
        @date_address.prefecture_id = 1
        @date_address.valid?
        expect(@date_address.errors.full_messages).to include('Prefecture のセレクタから選択して下さい')
      end
      it '市区町村がないと購入出来ない' do
        @date_address.city = ''
        @date_address.valid?
        expect(@date_address.errors.full_messages).to include("City can't be blank")
      end
      it '番地がないと購入出来ない' do
        @date_address.address = ''
        @date_address.valid?
        expect(@date_address.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号がないと購入出来ない' do
        @date_address.phone_number = ''
        @date_address.valid?
        expect(@date_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号は、10桁以上11桁以内の全角数値だと購入出来ない' do
        @date_address.phone_number = '３３３３３３３３３３'
        @date_address.valid?
        expect(@date_address.errors.full_messages).to include('Phone number input only number')
      end
      it '電話番号は、９桁以下の半角数値だと購入出来ない' do
        @date_address.phone_number = '7777777'
        @date_address.valid?
        expect(@date_address.errors.full_messages).to include('Phone number input only number')
      end
      it '電話番号は、12桁以上の半角数値だと購入出来ない' do
        @date_address.phone_number = '55555555555555'
        @date_address.valid?
        expect(@date_address.errors.full_messages).to include('Phone number input only number')
      end
      it '電話番号が数字のみでないと購入できないこと(英数混合)' do
        @date_address.phone_number = 'o555555555o'
        @date_address.valid?
        expect(@date_address.errors.full_messages).to include('Phone number input only number')
      end
      it '電話番号が数字のみでないと購入できないこと(ハイフンあり)' do
        @date_address.phone_number = '555-555-555'
        @date_address.valid?
        expect(@date_address.errors.full_messages).to include('Phone number input only number')
      end
      it 'userが紐付いていないと購入できないこと' do
        @date_address.user_id = nil
        @date_address.valid?
        expect(@date_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと購入できないこと' do
        @date_address.item_id = nil
        @date_address.valid?
        expect(@date_address.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenがないと購入出来ない' do
        @date_address.token = nil
        @date_address.valid?
        expect(@date_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
