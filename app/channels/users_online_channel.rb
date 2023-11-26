class UsersOnlineChannel < ApplicationCable::Channel
  before_unsubscribe :handle_offline

  def subscribed
    stream_from 'users_online_channel'
    stream_for current_user

    UserStatus.make_online(current_user)
  end

  def unsubscribed; end

  private

  def handle_offline
    HandleOfflineJob.
      set(wait_until: 5.seconds.from_now).
      perform_later(current_user)
  end
end
