class ChatroomsController < ApplicationController
  def index
    #自分の作成した仕事のidをすべて取得
    myjob_ids = Job.where(user_id: current_user.id).pluck(:id)
    
    #自分がオファーしたものor自分の仕事に紐づいてるチャットルームをすべて取得
    @chatrooms = Chatroom.where(job_id: myjob_ids).or(Chatroom.where(user_id: current_user.id))
    
    # @chatrooms each do |chatroom|
    #   @partner_unread_messages = chatroom.messages.where.not(user_id: current_user.id).where(read_status: false)
    # end
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
