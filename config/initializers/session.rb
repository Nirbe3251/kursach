Warden::Manager.after_set_user do |user,auth,opts|
    scope = opts[:scope]
    auth.cookies.signed["#{scope}.id"] = user.id
    auth.cookies.signed["#{scope}.expires_at"] = Devise::timeout_in.from_now
end
Warden::Manager.before_logout do |user, auth, opts|
    Rails.logger.info('LOGOUT USER')
    ActionCable.server.remote_connections.where(current_user: user).disconnect
    scope = opts[:scope]
    auth.cookies.delete("#{scope}.id")
    auth.cookies.delete("#{scope}.expires_at")
end