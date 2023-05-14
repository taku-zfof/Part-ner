class JobsController < ApplicationController
  def new
    @job=Job.new
  end

  def create
    job=Job.new(job_params)
    job.user = current_user
    job.near_station_line = ""
    job.near_station = "" # 一度保存しないとgeocoderが動かないため最寄り駅空欄でいったん保存

    if params[:post] # 投稿する場合
      if job.save(context: :release)
        # 最寄り駅情報を取得して代入
        uri = URI.parse("http://express.heartrails.com/api/json?method=getStations&x=#{job.longitude}&y=#{job.latitude}")
        response = Net::HTTP.get_response(uri)
        result = JSON.parse(response.body)
        job.near_station = result["response"]["station"][0]["name"]
        job.near_station_line = result["response"]["station"][0]["line"]
        # 再度保存
        job.save
        redirect_to job_path(job),flash: {notice: '募集を作成しました'}
      else
        @job=job
        flash.now[:error] = '作成に失敗しました'
        render :new
      end

    else  # 下書きの場合
      if job.update(released: false)
        redirect_to job_draft_index_path, flash: {notice: "募集を下書き保存しました！"}
      else
        @job=job
        flash.now[:error] = '下書き保存に失敗しました'
        render :new
      end
    end

  end

  def show
    @job=Job.find(params[:id])
  end

  def edit
    @job=Job.find(params[:id])
  end

  def update
    job=Job.find(params[:id])
    if params[:post] #投稿する場合
        job.attributes = job_params #updateにcontextが適用できないため。
        job.released = true
        if job.save(context: :release)
          # 最寄り駅情報を取得して代入
          uri = URI.parse("http://express.heartrails.com/api/json?method=getStations&x=#{job.longitude}&y=#{job.latitude}")
          response = Net::HTTP.get_response(uri)
          result = JSON.parse(response.body)
          job.near_station = result["response"]["station"][0]["name"]
          job.near_station_line = result["response"]["station"][0]["line"]
          job.save
          redirect_to job_path(job),flash: {notice: '募集を公開しました'}
        else
          @job=job
          flash.now[:error] = '公開できませんでした'
          render :edit
        end
    else #下書きにする場合
        job.released = false
        if job.update(job_params)
          redirect_to job_draft_index_path, flash: {notice: "募集を下書き保存しました"}
        else
          @job=job
          flash.now[:error] = '下書き保存に失敗しました'
          render :edit
        end
    end
      
  end

  def destroy
    job=Job.find(params[:id])
    if job.destroy
      redirect_to jobs_path, flash: {alert: '募集を削除しました'}
    else
      flash.now[:error] = '削除できませんでした'
      render :edit
    end
  end

  def index
    @jobs=Job.where(released: true).all
  end

  def draft_index
    @jobs = current_user.jobs.where(released: false).all
  end

  def search
    @jobs = Job.all
    @jobs = @jobs.where(prefecture_code: params[:prefecture_code]) if params[:prefecture_code].present?
    @jobs = @jobs.where(job_type: params[:job_type]) if params[:job_type].present?
    @jobs = @jobs.where('tytle LIKE(?) or introduction LIKE(?)',"%#{params[:key_word]}%","%#{params[:key_word]}%") if params[:key_word].present?
    render :index
  end

private
  def job_params
    params.require(:job).permit(:tytle, :job_type, :image, :introduction, :hourly_wage, :postal_code, :prefecture_code, :other_address ,:near_station, :near_station_line)
  end
end
