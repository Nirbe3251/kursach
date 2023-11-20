class User < ApplicationRecord
  has_many :messages, dependent: :destroy

  before_create :generate_nickname

  scope :online, -> { where(online: true) }

  private

  def generate_nickname
    self.nickname = Faker::Name.first_name.downcase
  end
end
