class OffersController < ApplicationController
  def create
    offer=Offer.new(offer_params)
    offer.user = current_user
    offer.save
    redirect_to request.referrer
  end
  
  def destroy
    offer = Offer.find(params[:offer_id])
    offer.destroy
    redirect_to request.referrer
  end
  
  # もらったオファー一覧
  def index
    myjobs_ids = Job.where(user_id: current_user.id).pluck(:id)
    @offers = Offer.where(job_id: myjobs_ids) 
  end
  
  #送ったオファー一覧
  def send_index
    @offers = current_user.offers.all
  end
  
  private
  
  def offer_params
    params.require(:offer).permit(:content, :job_id)
  end
  
end
