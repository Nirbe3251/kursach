class UserStatus
  class << self
    def make_online(user)
      user.update(online: true)
      broadcast(user)
    end

    def make_offline(user)
      user.update(online: false)
      broadcast(user)
    end

    private

    def broadcast(user)
      ActionCable.server.broadcast('users_online_channel', user.as_json)
    end
  end
end
