class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  before_commit do
    break if del_messages
  end

  def del_messages
    RoomUser.check_user_ban(room_id, user_id)
  end
end
