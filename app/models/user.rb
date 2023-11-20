class User < ApplicationRecord
  has_many :messages, dependent: :destroy
<<<<<<< HEAD
  has_many :room_users
  has_many :rooms, through: :room_users, dependent: :destroy
=======
  has_many :rooms, dependent: :destroy
>>>>>>> room destroy add
  before_create :generate_nickname
  scope :online, -> { where(online: true) }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private
       
  def generate_nickname
    self.nickname = Faker::Name.first_name.downcase
  end
end
