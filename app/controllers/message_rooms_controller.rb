class MessageRoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = RoomUser.where(user_id: current_user.id)
  end

  def create
    @is_room = ''
    current_user_entry = RoomUser.where(user_id: current_user.id)
    user_entry = RoomUser.where(user_id: params[:user_id])
    current_user_entry.each do |cu|
      user_entry.each do |u|
        @is_room = cu.room_id if cu.room_id == u.room_id
      end
    end

    redirect_to user_message_room_messages_path(current_user.id, @is_room) and return unless @is_room.blank?

    room = Room.new(user_ids: [current_user.id, params[:user_id]])
    if room.save
      redirect_to(user_message_room_messages_path(current_user.id, room.id))
    else
      render :index
    end
  end
end
