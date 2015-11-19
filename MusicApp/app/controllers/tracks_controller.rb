class TracksController < ApplicationController

  def index
    @album = Album.find(params[:album_id])
    @tracks = @album.tracks
  end

  def show
    @track = Track.find(params[:id])
    @album = @track.album
  end

  def new
    @track = Track.new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_url(@track)
    else
      render :new
    end
  end

  def edit
    @track = Track.find(params[:id])
  end

  def update
    @track = Track.find(params[:id])
    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @album = @track.album
    @track.destroy if @track
    redirect_to album_tracks_url(@album)
  end

  private
  def track_params
    params[:track].permit(:name, :album_id, :lyrics, :track_type)
  end
end
