module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user

      logger.add_tags 'ActionCable', current_user.nickname
    end

    private

    def find_verified_user
      verified_user = env['warden'].user
      if verified_user && cookies.signed['user.expires_at'] > Time.now
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
