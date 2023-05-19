class MessageBroadcastJob < ApplicationJob
  queue_as :default
  def perform(message)
    ActionCable.server.broadcast "chatroom_channel_#{message.chatroom_id}", {message: render_message(message)}
  end

  private

    def render_message(message)
      ApplicationController.render_with_signed_in_user(message.user, {partial: 'chatrooms/message', locals: { message: message }})
    end
end
