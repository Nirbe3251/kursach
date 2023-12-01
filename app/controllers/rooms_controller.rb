class RoomsController < ApplicationController
  before_action :set_room, only: %i[show check_password]

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

  private

  def room_params
    params.require(:room).permit(:name)
  end

  def set_room
    @room = Room.find_by(token: params[:token])
  end
end
