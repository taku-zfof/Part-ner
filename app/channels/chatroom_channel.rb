# frozen_string_literal: true

class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chatroom_channel_#{params['chatroom_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
  
  # chatroom.jsからmessageとchatroom_idをもらってきてメッセージを作成。その次にmessage_broadcast_jobが動く。
  def speak(data)
    Message.create! content: data["message"], user_id: current_user.id, chatroom_id: params["chatroom_id"]
  end
end


