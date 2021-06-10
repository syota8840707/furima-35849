require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe '新規登録ユーザー情報' do
    it 'ニックネーム、メールアドレス、パスワード、パスワード（認証）、名前、名字、生年月日があれば登録できる' do
      expect(@user).to be_valid
    end
    it 'nicknameがないと登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'メールアドレスがないと登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'メールアドレスが一意性でないと登録できない' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end
    it 'メールアドレスは。＠を含まないと登録出来ない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'パスワードがないと登録出来ない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'パスワードが６文字以上なら登録できる' do
      @user.password
      @user.password_confirmation
      expect(@user).to be_valid
    end
    it 'パスワードが5文字以下だと登録できない' do
      @user.password = '12345'
      @user.password_confirmation = '12345'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
    it 'パスワードとパスワード（認証）は一致しないと登録できない' do
      @user.password = '1234567'
      @user.password_confirmation = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'パスワードは半角英数字混合でないと登録出来ない' do
      @user.password = 'xxxxxxxx'
      @user.password_confirmation = 'xxxxxxxx'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is invalid', 'Password confirmation is invalid')
    end
    it 'お名前（全角）は、名字が無いと登録出来ない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    it 'お名前（全角）は、名前が無いと登録出来ない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it 'お名前（全角）は、名字が全角（漢字、ひらがな、カタガナ）での入力でないと登録出来ない' do
      @user.last_name = 'xxx'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name は全角ひらがな、全角カタカナ、漢字で入力して下さい')
    end
    it 'お名前（全角）は、名前が全角（漢字、ひらがな、カタガナ）での入力でないと登録出来ない' do
      @user.first_name = 'ﾘﾘﾘr'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name は全角ひらがな、全角カタカナ、漢字で入力して下さい')
    end
    it 'お名前カナ（全角）は、名字がないと登録出来ない' do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end
    it 'お名前カナ（全角）は、名前がないと登録出来ない' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end
    it 'お名前カナ（全角）は、名字が全角（カタカナ）での入力でないと登録出来ない' do
      @user.last_name_kana = 'まえだ'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kana は全角カタカナで入力して下さい')
    end
    it 'お名前カナ（全角）は、名前が全角（カタカナ）での入力でないと登録出来ない' do
      @user.first_name_kana = '前田'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana は全角カタカナで入力して下さい')
    end
    it '生年月日がないと登録出来ない' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end
