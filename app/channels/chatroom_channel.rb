class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chatroom_channel_#{params['chatroom_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create! content: data['message'], user_id: current_user.id, chatroom_id: params['chatroom_id']
  end
end


