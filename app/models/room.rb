class Room < ApplicationRecord
  validates :name, presence: true
  has_many :messages, dependent: :destroy
  # has_many :users
  has_and_belongs_to_many :users, join_table: :room_users, foreign_key: "room_id"

  enum status: { pub: false, priv: true }

  before_create :generate_token

  def to_param
    token
  end

  private

  def generate_token
    self.token = SecureRandom.hex(2)
  end
end
