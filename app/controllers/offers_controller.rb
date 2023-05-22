class OffersController < ApplicationController
  def create
    offer=Offer.new(offer_params)
    offer.user = current_user
    offer.save
    redirect_to request.referrer,flash: {notice: 'オファーを送りました！'}
  end

  def destroy
    offer = Offer.find(params[:offer_id])
    offer.destroy
    redirect_to request.referrer,flash: {error: 'オファーを削除しました'}
  end

  # もらったオファー一覧
  def index
    myjobs_ids = Job.where(user_id: current_user.id).pluck(:id)
    @receive_offers = Offer.where(job_id: myjobs_ids)
    @send_offers = current_user.offers.all
  end
  
  private

  def offer_params
    params.require(:offer).permit(:content, :job_id)
  end

end
