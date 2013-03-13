class VideosController < ApplicationController
  
  def index
    @videos = Video.all
    respond_to do |format|
      format.json{ render :json=>@videos }
    end
  end
  
  def show
    @video = Video.find(params[:id])
    
    respond_to do |format|
      format.json{ render :json=>@video }
    end
  end
  
  def create
    @video = Video.new(params[:video])
    if @video.save
      redirect_to "/#/videos/#{@video.id}"
    else
      redirect_to '/#/videos/new'
    end
  end
  
end
