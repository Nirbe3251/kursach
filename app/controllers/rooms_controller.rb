class RoomsController < ApplicationController
  before_action :set_room, only: %i[show set_room_user check_password user_ban add_user check_banned]
  before_action :set_room_user, only: %i[show]
  before_action :check_banned, only: %i[show]
 
  def index
    @rooms = Room.all
    @room = Room.new
    @users_online = User.online
  end

  def show
  end

  def new
    @room = Room.new
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
          logger.info("Password true")
          # logger.info(render json: {password: false})
          render plain: true
        else
          logger.info("Password false")
          # logger.info(render json: {password: false})
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
    response.header["Content-Type"] = 'application/json'
    respond_to do |format|
      format.json {
        status = RoomUser.ban(@room.id, params[:user_id], params[:target])

        render plain: true if status == 'banned'
        render plain: false if status == 'unbanned'
      }
    end
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

  def check_banned
    status = RoomUser.check_user_ban(@room.id, current_user.id)
    Rails.logger.info("Status Ban:::#{status}")
    if status
      redirect_to root_path
    # else
      # redirect_to room_path(@room.token)
    end
  end
end
