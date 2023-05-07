class BookmarksController < ApplicationController
  def create
    @bookmark=Bookmark.new(user_id: current_user.id,job_id: params[:job_id])
    @bookmark.save
    @job = Job.find(params[:job_id])
  end

  def destroy
    bookmark=Bookmark.find_by(user_id: current_user.id,job_id: params[:job_id])
    bookmark.destroy
    
    @job = Job.find(params[:job_id])
  end

  def index
    job_ids=Bookmark.where(user_id: current_user.id).pluck(:job_id)
    @jobs=Job.where(id: job_ids)
  end
end
