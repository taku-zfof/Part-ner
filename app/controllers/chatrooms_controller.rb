class ChatroomsController < ApplicationController
  def index
    myjob_ids = Job.where(user_id: current_user.id).pluck(:id)
    
    #自分がオファーしたものor自分の仕事に紐づいてるチャットルームをすべて取得
    @chatrooms = Chatroom.where(job_id: myjob_ids).or(Chatroom.where(user_id: current_user.id))
  end

  def show
    @chatroom = Chatroom.find(params[:id])
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
