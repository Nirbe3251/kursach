class RoomsController < ApplicationController
  before_action :set_room, only: :show

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
    
    Rails.logger.info("START CREATE_________________-")

    Rails.logger.info("CREATE ROOMS WITH PARAMS: #{params}")
    
    @room = Room.new(room_params)
    @room.user_id = current_user.id
    current_user.rooms << @room
    @room.priv! if params[:room][:status] == 'true'
    @room.password = params[:room][:password] if params[:room][:password].present?

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
