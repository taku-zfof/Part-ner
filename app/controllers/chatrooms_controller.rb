# frozen_string_literal: true

class ChatroomsController < ApplicationController
  before_action :ensure_user, only:[:show]

  def index
    #selfchatはモデルに記載、の中からメッセージ新着順に並べる。
    chatrooms = Chatroom.selfchat(current_user).joins(:messages).includes(:messages).order("messages.created_at DESC")
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

    # チャット相手のメッセージをすべて既読にする
    partner_messages = @messages.where.not(user_id: current_user.id)
    partner_messages.update(read_status: true)
  end

  def create
    chatroom = Chatroom.new
    chatroom.user = User.find(params[:offerer_id])
    chatroom.job = Job.find(params[:job_id])
    if chatroom.save
      # チャットルーム作成したらオファー削除
      offer = Offer.find(params[:offer_id])
      offer.destroy

      # 応募ユーザーにメール送信
      @mail_to = chatroom.user
      @job = chatroom.job
      OfferOkMailer.send_mail(@mail_to, @job).deliver_later

      chatroom.messages.create(user_id: current_user.id, content: "オファーありがとうございます！", read_status: false)
      redirect_to chatroom_path(chatroom),flash: {notice: "メッセージを送ってみましょう！"}
    else
      myjobs_ids = Job.where(user_id: current_user.id).pluck(:id)
      @receive_offers = Offer.where(job_id: myjobs_ids)
      @send_offers = current_user.offers.all
      flash.now[:error] = "承認に失敗しました"
      render "offers/index"
    end
  end

  def change_hide
    chatroom = Chatroom.find_by(rondom_id: params[:chatroom_rondom_id])
    chatroom.hidden ? chatroom.update(hidden: false) : chatroom.update(hidden: true)
    redirect_to chatrooms_path
  end

  private
    def ensure_user
      chatroom = Chatroom.find_by(rondom_id: params[:rondom_id])
      unless chatroom.user == current_user or chatroom.job.user == current_user
        redirect_back fallback_location: user_path(current_user), flash: {error: "権限がありません。"}
      end
    end

end
