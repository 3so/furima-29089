class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze

  with_options presence: true do
    validates :nickname
    validates :password,            format: { with: PASSWORD_REGEX, message: "Password Include both letters and numbers" }
    validates :family_name,         format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: "Last name Full-width characters"}
    validates :first_name,          format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: "First name Full-width characters" }
    validates :family_name_reading, format: { with: /\A[ァ-ン]+\z/, message: "Last name kana Full-width katakana characters" }
    validates :first_name_reading,  format: { with: /\A[ァ-ン]+\z/, message: "First name kana Full-width katakana characters" }
    validates :birthday
  end
end
