class Room < ApplicationRecord
  validates :name, presence: true
  has_many :messages, dependent: :destroy
  # has_many :users
  has_and_belongs_to_many :users, join_table: :room_users, foreign_key: "room_id"

  enum status: { pub: false, priv: true }

  before_create :generate_token

  def self.search(search)
    res = all
    if search.present?
      res = res.where('name LIKE ?', "%#{search[:name]}%") if search[:name].present?
      res = res.where(status: search[:status]) if search[:status].present?
    end
    res
  end

  def to_param
    token
  end

  def user_include?(user)
    users.ids.include? user.id
  end

  private

  def generate_token
    self.token = SecureRandom.hex(2)
  end
end
