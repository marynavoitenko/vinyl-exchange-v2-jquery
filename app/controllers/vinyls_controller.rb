class VinylsController < ApplicationController
  def index
    if params[:artist_id]
      @vinyls = Vinyl.all.where("artist_id = ?", params[:artist_id])
    else
      @vinyls = Vinyl.all
    end
  end

  def new
    if params[:artist_id] && !Artist.exists?(params[:artist_id])
      redirect_to store_path, alert: "Artist not found."
    elsif params[:artist_id] && Artist.exists?(params[:artist_id])
      @vinyl = Vinyl.new(artist_id: params[:artist_id])
    else
      @vinyl = Vinyl.new
    end
  end

  def create
    @vinyl = current_user.vinyls.new(vinyl_params)
    if params[:artist_id]
      @artist = Artist.find(params[:vinyl][:artist_id])
      @vinyl.artist = @artist
    end
    if @vinyl.save
      redirect_to vinyl_path(@vinyl)
    else
      render :new
    end
  end

  def show
    @vinyl = Vinyl.find(params[:id])
  end

  def edit
    if !@vinyl = Vinyl.find_by(id: params[:id])
      redirect_to vinyls_path
    end
  end

  def update
    @vinyl = current_user.vinyls.find(params[:id])

    if @vinyl.update(vinyl_params)
      if params[:vinyl][:artist_id]
        @artist = Artist.find(params[:vinyl][:artist_id])
        @vinyl.artist = @artist
        @vinyl.save
      end
      redirect_to vinyl_path(@vinyl)
    else
      render :edit
    end
  end

  def destroy
    Vinyl.find(params[:id]).destroy
    redirect_to vinyls_path
  end

  private

  def vinyl_params
    params.require(:vinyl).permit(:title, :price, :inventory, :artist_id, genre_ids:[], genres_attributes: [:name], artist_attributes: [:name])
  end
end
