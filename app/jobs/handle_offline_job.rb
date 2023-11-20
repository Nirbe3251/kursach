class HandleOfflineJob < ApplicationJob
  queue_as :critical

  def perform(user)
    return if UsersOnlineChannel.broadcast_to(user, action: 'presence-check').to_i.positive?

    UserStatus.make_offline(user)
  end
end
