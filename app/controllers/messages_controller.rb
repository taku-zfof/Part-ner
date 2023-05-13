class MessagesController < ApplicationController
  def create
    message = Message.new(message_params)
    message.save
    redirect_to request.referrer
  end
  
  private
  def message_params
    params.require(:message).permit(:user_id, :content, :chatroom_id)
  end
end
