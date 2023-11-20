class User < ApplicationRecord
  has_many :messages, dependent: :destroy
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
