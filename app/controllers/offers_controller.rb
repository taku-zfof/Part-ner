# frozen_string_literal: true

class OffersController < ApplicationController
  before_action :ensure_user, only:[:destroy]

  def create
    offer=Offer.new(offer_params)
    offer.user = current_user
    offer.save
    flash.now[:notice] = "オファーを送りました！"
    # メールを作成。deliver_laterでバックグラウンド処理になる
    @from = offer.user
    @job = offer.job
    @content = offer.content
    OfferReceiveMailer.send_mail(@from, @job, @content).deliver_later
  end

  def destroy
    @offer = Offer.find(params[:offer_id])
    @offer.destroy
    flash.now[:alert] = "オファーを削除しました"

    #以下は非同期通信のため追加
    myjobs_ids = Job.where(user_id: current_user.id).pluck(:id)
    @receive_offers = Offer.where(job_id: myjobs_ids) # もらったオファー一覧
    @send_offers = current_user.offers.all # 送ったオファー一覧
  end


  def index
    myjobs_ids = Job.where(user_id: current_user.id).pluck(:id)
    @receive_offers = Offer.where(job_id: myjobs_ids) # もらったオファー一覧
    @send_offers = current_user.offers.all # 送ったオファー一覧
  end

  private
    def offer_params
      params.require(:offer).permit(:content, :job_id)
    end

    def ensure_user
      offer = Offer.find(params[:offer_id])
      unless offer.user == current_user or offer.job.user == current_user
        redirect_back fallback_location: user_path(current_user), flash: {error: "権限がありません。"}
      end
    end

end
