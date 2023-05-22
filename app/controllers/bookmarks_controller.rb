class BookmarksController < ApplicationController
  def create
    @bookmark=Bookmark.new(user_id: current_user.id,job_id: params[:job_id])
    @bookmark.save
    @job = Job.find(params[:job_id]) # 非同期書処理のため追加
     flash.now[:notice] = 'ブックマークしました'
  end

  def destroy
    bookmark = Bookmark.find_by(user_id: current_user.id, job_id: params[:job_id])
    bookmark.destroy
    @job = Job.find(params[:job_id]) # 非同期書処理のため追加
    flash.now[:alert] = 'ブックマークを解除しました'
  end

  def index
    job_ids=Bookmark.where(user_id: current_user.id).pluck(:job_id)
    @jobs=Job.where(id: job_ids).page(params[:page]).per(5) #ページネーション（無限スクロール）
  end
end
