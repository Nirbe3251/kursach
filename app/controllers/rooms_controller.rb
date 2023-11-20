class RoomsController < ApplicationController
  before_action :set_room, only: :show

  def index
    @rooms = Room.all
    @room = Room.new
    @users_online = User.online
  end

  def show
  end

  def create
    
    Rails.logger.info("START CREATE_________________-")

    @room = Room.create!(user: current_user)

    redirect_to @room, notice: t('.room_created')
  end

  def destroy
    @rm = Room.find_by(token: params[:token])
    @rm.destroy!
    redirect_to rooms_path
  end

  private

  def set_room
    @room = Room.find_by(token: params[:token])
  end
end
