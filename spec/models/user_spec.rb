require 'rails_helper'

describe User do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー管理機能の実装' do
    context 'ユーザー情報の登録' do
      it 'ニックネーム、メールアドレス、パスワードが条件を満たしていれば登録できること' do
        expect(@user).to be_valid
      end
      it 'ニックネームが空では登録できないこと' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスが空では登録できないこと' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'メールアドレスは@を含む必要があること' do
        @user.email = "test"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'パスワードが必須であること' do
        @user.password = nil
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードは6文字以上であること' do
        @user.password = "aaaa5"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'パスワードは半角英数字混合であること' do
        @user.password = "aaaaaa"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
      end
      it 'パスワードは確認用を含めて2回入力すること' do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '新規登録・ログイン共にエラーハンドリングができていること（適切では無い値が入力された場合、情報は受け入れられず、エラーメッセージを出力させる）' do
        @user.nickname = nil
        @user.valid?
        expect{
          @user.save
        }.not_to change{ User.count }
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
    end

    context '本人情報の確認' do
      it 'ユーザー本名、ユーザー本名のフリガナ、生年月日が条件を満たしていれば登録できること' do
        expect(@user).to be_valid
      end
      it 'ユーザー本名が、名字が必須であること' do
        @user.family_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end
      it 'ユーザー本名が、名前が必須であること' do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'ユーザー本名の名字は全角（漢字・ひらがな・カタカナ）で入力させること' do
        @user.family_name = "a"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name Full-width characters")
      end
      it 'ユーザー本名の名前は全角（漢字・ひらがな・カタカナ）で入力させること' do
        @user.first_name = "a"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name Full-width characters")
      end
      it 'ユーザー本名のフリガナが、名字が必須であること' do
        @user.family_name_reading = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name reading can't be blank")
      end
      it 'ユーザー本名のフリガナが、名前が必須であること' do
        @user.first_name_reading = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name reading can't be blank")
      end
      it 'ユーザー本名の名字のフリガナは全角（漢字・ひらがな・カタカナ）で入力させること' do
        @user.family_name_reading = "a"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name reading Full-width katakana characters")
      end
      it 'ユーザー本名の名前のフリガナは全角（漢字・ひらがな・カタカナ）で入力させること' do
        @user.first_name_reading = "a"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name reading Full-width katakana characters")
      end
      it '生年月日が必須であること' do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end