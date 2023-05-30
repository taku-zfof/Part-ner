# frozen_string_literal: true

class JobsController < ApplicationController
  before_action :ensure_user, only:[:edit, :update, :destroy]

  def new
    @job=Job.new
    @renderd = "renderd"
  end

  def create
    job=Job.new(job_params)
    job.user = current_user
    job.near_station_line = ""
    job.near_station = "" # 一度保存しないとgeocoderが動かないため最寄り駅空欄でいったん保存

    if params[:post] # 投稿する場合
      if job.save(context: :release)
        # 最寄り駅情報を取得して再保存
        job.addStation
        redirect_to job_path(job),flash: {notice: "募集を公開しました"}
      else
        @job = job
        flash.now[:error] = "作成に失敗しました"
        render :new
      end

    else  # 下書きの場合
      if job.update(released: false)
        redirect_to job_draft_index_path, flash: {notice: "募集を下書き保存しました！"}
      else
        @job=job
        flash.now[:error] = "下書き保存に失敗しました"
        render :new
      end
    end

  end

  def show
    @job=Job.find_by(rondom_id: params[:rondom_id])
  end

  def edit
    @job=Job.find_by(rondom_id: params[:rondom_id])
  end

  def update
    job=Job.find_by(rondom_id: params[:rondom_id])
    if params[:post] # 投稿する場合
        job.attributes = job_params # updateにcontextが適用できないためattributeで代入してからsave
        job.released = true
        if job.save(context: :release)
          # 最寄り駅情報を取得して代入
          job.addStation
          redirect_to job_path(job),flash: {notice: "募集を公開しました"}
        else
          @job=job
          flash.now[:error] = "公開できませんでした"
          render :edit
        end
    elsif params[:draft] # 下書きにする場合
        job.released = false
        if job.update(job_params)
          redirect_to job_draft_index_path, flash: {notice: "募集を下書き保存しました"}
        else
          @job=job
          flash.now[:error] = "下書き保存に失敗しました"
          render :edit
        end
    end

  end

  def destroy
    job=Job.find_by(rondom_id: params[:rondom_id])
    if job.destroy
      redirect_to user_path(current_user), flash: {notice: "募集を削除しました"}
    else
      flash.now[:error] = "削除できませんでした"
      render :edit
    end
  end

  def draft_index
    @jobs = current_user.jobs.where(released: false).all
    @jobs = Kaminari.paginate_array(@jobs).page(params[:page]).per(5) # ページネーション（無限スクロール用）
  end


  def search
    @jobs = Job.where(released: true).all.shuffle
    # 条件が存在する場合のみ絞り込む
    @jobs = @jobs.where(prefecture_code: params[:prefecture_code]) if params[:prefecture_code].present?
    @jobs = @jobs.where(job_type: params[:job_type]) if params[:job_type].present?
    @jobs = @jobs.where("tytle LIKE(?) or introduction LIKE(?)","%#{params[:key_word]}%","%#{params[:key_word]}%") if params[:key_word].present?
    @jobs = @jobs.where.not("introduction LIKE(?)", "%【この情報はサンプルです】%" ) if params[:include_sample] == "1" # チェックボックスが選択されていたらサンプルを除外
    @jobs = Kaminari.paginate_array(@jobs).page(params[:page]).per(5) # ページネーション（無限スクロール用）
    render :index
  end

private
  def job_params
    params.require(:job).permit(:rondom_id, :tytle, :job_type, :image, :introduction, :hourly_wage, :postal_code, :prefecture_code, :other_address ,:near_station, :near_station_line)
  end

  def ensure_user
    job=Job.find_by(rondom_id: params[:rondom_id])
    unless job.user == current_user
      redirect_back fallback_location: user_path(current_user), flash: {error: "権限がありません。"}
    end
  end
end
