require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    describe 'ユーザー新規登録' do
      context '新規登録できるとき' do
        it '必要な値が正常に入力されれた登録できる' do
          expect(@user).to be_valid
        end
        it 'passwordとpassword_confirmationが英数混合6文字以上であれば登録できる' do
          @user.password = 'aaa000'
          @user.password_confirmation = 'aaa000'
          expect(@user).to be_valid
        end
      end

      context '新規登録できないとき' do
        context 'ユーザー情報' do
          it '重複したnicknameが存在する場合登録できない' do
            @user.save
            another_user = FactoryBot.build(:user)
            another_user.nickname = @user.nickname
            another_user.valid?
            expect(another_user.errors.full_messages).to include('Nickname has already been taken')
          end
          it 'nicknameが空では登録できない' do
            @user.nickname = ''
            @user.valid?
            expect(@user.errors.full_messages).to include("Nickname can't be blank")
          end
          it 'passwordが空では登録できない' do
            @user.password = ''
            @user.valid?
            expect(@user.errors.full_messages).to include("Password can't be blank")
          end
          it 'passwordが存在してもpassword_confirmationが空では登録できない' do
            @user.password_confirmation = ''
            @user.valid?
            expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
          end
          it 'passwordが5文字以下では登録できない' do
            @user.password = 'a'
            @user.valid?
            expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
          end
          it 'passwordが英語のみでは登録できない' do
            @user.password = 'abcdefg'
            @user.password_confirmation = @user.password
            @user.valid?
            expect(@user.errors.full_messages).to include('Password is invalid')
          end
          it 'passwordが数字のみでは登録できない' do
            @user.password = '123456'
            @user.password_confirmation = @user.password
            @user.valid?
            expect(@user.errors.full_messages).to include('Password is invalid')
          end
          it 'passwordが全角では登録できない' do
            @user.password = '１２３４５６' # 全角数字
            @user.password_confirmation = @user.password
            @user.valid?
            expect(@user.errors.full_messages).to include('Password is invalid')
          end
        end
      end
    end
  end
end
