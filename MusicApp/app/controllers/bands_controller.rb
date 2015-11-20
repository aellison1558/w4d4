class BandsController < ApplicationController
  def index
    @bands = Band.all
  end

  def show
    @band = Band.find(params[:id])
  end

  def new
    @band = Band.new
  end

  def create
    @band = Band.new(band_params)

    if @band.save
      redirect_to band_url(@band)
    else
      render :new
    end
  end

  def edit
    @band = Band.find(params[:id])
  end

  def update
    @band = Band.find(params[:id])
    
    if @band.update(band_params)
      redirect_to band_url(@band)
    else
      render :edit
    end
  end

  def destroy
    @band = Band.find(params[:id])
    @band.destroy if @band
    redirect_to root_url
  end

  private
  def band_params
    params[:band].permit(:name)
  end
end
