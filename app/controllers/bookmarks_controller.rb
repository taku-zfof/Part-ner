class BookmarksController < ApplicationController
  def create
    Bookmark.create(user_id: current_user.id,job_id: params[:job_id])
    redirect_to request.referer
  end
  
  def destroy
    bookmark=Bookmark.find_by(user_id: current_user.id,job_id: params[:job_id])
    bookmark.destroy
    redirect_to request.referer
  end
end
