class MessageBroadcastJob < ApplicationJob
  queue_as :default
  #下で呼び出しているmessageパーシャルを”message"に入れてchatroom_channnelのreceivedに送る
  def perform(message)
    ActionCable.server.broadcast "chatroom_channel_#{message.chatroom_id}", {message: render_message(message)}
  end

  private
    
    #ここでapplication_controllerで作成してあるrender_with_signed_in_userを呼び、messageパーシャルを取得。
    def render_message(message)
      ApplicationController.render_with_signed_in_user(message.user, {partial: 'chatrooms/message', locals: { message: message }})
    end
end
