module ApplicationHelper
    def check_ban(room_id, user_id)
        RoomUser.check_user_ban(room_id,user_id)
    end
end
