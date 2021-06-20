class MessageRoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = RoomUser.where(user_id: current_user.id)
  end

  def create
    @is_room = room_check(params[:user_id])

    redirect_to user_message_room_messages_path(current_user.id, @is_room) and return unless @is_room.blank?

    room = Room.new(user_ids: [current_user.id, params[:user_id]])
    if room.save
      redirect_to(user_message_room_messages_path(current_user.id, room.id))
    else
      render :index
    end
  end

  def destroy
    room = Room.find(params[:id])
    room.destroy
  end
end
