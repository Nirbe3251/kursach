class User < ApplicationRecord
  has_many :messages
  has_many :room_users, dependent: :destroy
  has_many :rooms, through: :room_users
  has_one_attached :avatar
  # before_create :generate_nickname
  scope :online, -> { where(online: true) }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private

  before_destroy do
    check_rooms
  end

  def self.create_deleted_user
   user = where(nickname: 'deleted').first_or_create!(password: '123123', email: 'deleted@deleted')
   user.id
  end

  def check_rooms
    rooms = Room.includes(:users).where(user_id: id)
    messages = Message.where(user_id: id)
    rooms.each do |r|
      users = r.users
      if users.present?
        r.update(user_id: users.min.id)
      else
        r.destroy
      end
    end
    messages.each do |m|
      m.update(user_id: User.create_deleted_user)
    end
  end
end
