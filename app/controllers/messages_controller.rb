class MessagesController < ApplicationController
  def index
    @room = Room.includes(:messages).find(params[:message_room_id])
    @message = Message.new
    @messages = @room.messages.with_attached_image.includes(:user)
  end

  def create
    @room = Room.find(params[:message_room_id])
    @message = @room.messages.new(message_params)
    if @message.save
      if @message.image.blank?
        ActionCable.server.broadcast 'message_channel', content: @message
      else
        redirect_to(user_message_room_messages_path(current_user.id, params[:message_room_id]))
      end
    else
      @messages = @room.messages.includes(:user)
      render :index
    end
  end

  def destroy
    message = Message.find(params[:id])
    message.destroy
  end

  private

  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end
end
