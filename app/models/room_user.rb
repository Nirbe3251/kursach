class RoomUser < ApplicationRecord
  belongs_to :user
  belongs_to :room

  def self.check_user_ban(user_id)
    where(user_id: user_id).first.banned?
  end 

  def self.ban(room_id, user_id, target)
    user_room = find_by(user_id: user_id, room_id: room_id)
    user_room.update(banned: target)
    if user_room.banned?
      'banned'
    else
      'unbanned'
    end
  end
end