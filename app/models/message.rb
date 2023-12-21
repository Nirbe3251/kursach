class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  before_commit do
    Rails.logger.info("USER ID: #{user_id}")
    break if del_messages
  end

  def del_messages
    Rails.logger.info("USER ID: #{user_id}")
    RoomUser.check_user_ban(room_id, user_id)
  end
end
