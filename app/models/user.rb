class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :purchases

  with_options presence: true do
    validates :nickname
    validates :family_name,         format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'Full-width characters' }
    validates :first_name,          format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'Full-width characters' }
    validates :family_name_reading, format: { with: /\A[ァ-ン]+\z/, message: 'Full-width katakana characters' }
    validates :first_name_reading,  format: { with: /\A[ァ-ン]+\z/, message: 'Full-width katakana characters' }
    validates :birthday
  end

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates :password, format: { with: PASSWORD_REGEX, message: 'Include both letters and numbers' }
end
