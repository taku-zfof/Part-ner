class JobsController < ApplicationController
  def new
    @job=Job.new
  end

  def create
    job=Job.new(job_params)
    job.user = current_user
    job.near_station_line = ""
    job.near_station = "" # 一度保存しないとgeocoderが動かないため最寄り駅空欄でいったん保存
    if job.save
      # 最寄り駅情報を取得して代入
      uri = URI.parse("http://express.heartrails.com/api/json?method=getStations&x=#{job.longitude}&y=#{job.latitude}")
      response = Net::HTTP.get_response(uri)
      result = JSON.parse(response.body)
      job.near_station = result["response"]["station"][0]["name"]
      job.near_station_line = result["response"]["station"][0]["line"]
      # 再度保存
      job.save
      redirect_to job_path(job)
    else
      @job=job
      render :new
    end

  end

  def show
    @job=Job.find(params[:id])
  end

  def edit
    @job=Job.find(params[:id])
  end
  
  def update
    
  end

  def index
    @jobs=Job.all
  end

private
  def job_params
    params.require(:job).permit(:tytle, :job_type, :image, :introduction, :hourly_wage, :postal_code, :prefecture_code, :other_address ,:near_station, :near_station_line)
  end
end
