class RoomsController < ApplicationController
  before_action :set_room, only: %i[show set_room_user check_password user_ban add_user check_banned edit leave_room update]
  before_action :set_room_user, only: %i[show]
  before_action :check_banned, only: %i[show]
  after_action :check_banned, only: %i[show]
 
  def index
    @rooms = Room.search(params[:search])
    @room = Room.new
    @users_online = User.online
  end

  def show
    # Rails.logger.first
  end

  def edit;end

  def new
    @room = Room.new
  end
  
  def update
    if params.present?
      if params[:name].present?
        Rails.logger.info('start edit room name')
        @room.update(name: params[:name])
      elsif [:password].present?
        Rails.logger.info('start edit room password')
        @room.update(password: params[:password])
        @room.update(status: true) if @room.status == 'pub'
      end
      redirect_to room_path(@room.token)
    end
  end

  def create  
    @room = Room.new(room_params)
    @room.user_id = current_user.id
    current_user.rooms << @room    
    if params[:room][:password].present?
      @room.password = params[:room][:password]
      @room.priv!
    end

    if @room.save
      redirect_to @room, notice: t('.room_created')
    else
      redirect_to root_path
    end
  end

  def leave_room
    user = RoomUser.find_by(room_id: @room.id, user_id: params[:user_id])
    if user.delete
      redirect_to root_path
    end
  end

  def add_user
    response.header["Content-Type"] = 'application/json'
    respond_to do |format|
      format.json {
        begin
          user = User.find(params[:user_id])
          @room.users << user unless @room.users.include? user
          render plain: true
        rescue => e
          Rails.logger.error "#{e.message} #{e.backtrace}"
          render plain: false
        end
      }
    end
  end

  def destroy
    @rm = Room.find_by(token: params[:token])
    @rm.destroy!
    redirect_to rooms_path
  end

  def check_password
    response.header["Content-Type"] = 'application/json'
    respond_to do |format|
      format.json { 
        if @room.password == params[:password]
          user = User.find(params[:user_id])
          @room.users << user unless @room.users.include? user
          logger.info("Password true")
          render plain: true
        else
          logger.info("Password false")
          render plain: false
        end 
      }
    end
  end

  def destroy
    @rm = Room.find_by(token: params[:token])
    @rm.destroy!
    redirect_to rooms_path
  end

  def user_ban
    user = User.find(params[:user_id])
    show_name = user.nickname.present? ? user.nickname : user.email
    response.header["Content-Type"] = 'application/json'
    respond_to do |format|
      format.json {
        status = RoomUser.ban(@room.id, params[:user_id], params[:target])
        if status == 'banned'
          UsersOnlineChannel.broadcast_to user, room: @room.token, banned: true, user: user.id
          render plain: true
        end
        UsersOnlineChannel.broadcast_to user, room: @room.token, banned: false, user: user.id
        render plain: false if status == 'unbanned'
      }
    end
    # message = "Пользователь #{show_name} был заблокирован"
    # message = 'Вы были заблокированы' if current_user == user
    # ActionCable.server.broadcast("room_channel_#{@room.id}", { message: })
    # check_banned(user.id)
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end

  def set_room
    @room = Room.find_by(token: params[:token])
  end

  def set_room_user
    @room_user = RoomUser.where(room_id: @room.id)
  end

  def check_banned(u_id = current_user.id)
    status = RoomUser.check_user_ban(@room.id, u_id)
    if status
      redirect_to root_path
    else
      # redirect_to room_path(@room.token)
    end
  end
end
