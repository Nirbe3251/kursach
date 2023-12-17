module ApplicationHelper
    def check_ban(user_id)
        RoomUser.check_user_ban(user_id)
    end
end
