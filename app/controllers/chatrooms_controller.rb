class ChatroomsController < ApplicationController
  def index
    chatrooms = Chatroom.selfchat(current_user)
    @show_chatrooms = chatrooms.where(hidden: false)
    @hide_chatrooms = chatrooms.where(hidden: true)
  end

  def show
    @chatroom = Chatroom.find_by(rondom_id: params[:rondom_id])
    if @chatroom.user == current_user
      @partner = @chatroom.job.user
    else
      @partner = @chatroom.user
    end
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

  def change_hide
    chatroom = Chatroom.find_by(rondom_id: params[:chatroom_rondom_id])
    chatroom.hidden ? chatroom.update(hidden: false) : chatroom.update(hidden: true)
    redirect_to chatrooms_path
  end
end
