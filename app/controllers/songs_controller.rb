class SongsController < ApplicationController
  def index
    if params[:artist_id]
      @artist = Artist.find_by_id(params.require(:artist_id))
      unless @artist
        flash[:alert] = "Artist not found"
        redirect_to artists_path
      end 
      @songs = @artist&.songs
    else
    @songs = Song.all
    end
  end

  def show
    if params[:artist_id]
      @artist = Artist.find_by_id(params.require(:artist_id))
      @song = @artist.songs.find_by_id(params.require(:id))
      unless @song 
        flash[:alert] = "Song not found"
        redirect_to artist_songs_path(@artist)
      end 
    else 
    @song = Song.find(params[:id])
    end 
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end

