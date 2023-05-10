class ChatroomsController < ApplicationController
  def index
    @chatrooms = Chatroom.selfchat(current_user)
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    @messages = Message.where(chatroom_id: @chatroom.id)

    #チャット相手のメッセージをすべて既読にする
    partner_messages = @messages.where.not(user_id: current_user.id)
    partner_messages.update(read_status: true)
  end

  def create
    chatroom = Chatroom.new
    chatroom.user = User.find(params[:offerer_id])
    chatroom.job = Job.find(params[:job_id])
    chatroom.save

    #チャットルーム作成したらオファー削除
    offer = Offer.find(params[:offer_id])
    offer.destroy

    redirect_to chatroom_path(chatroom)
  end
end
