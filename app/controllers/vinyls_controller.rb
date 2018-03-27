class VinylsController < ApplicationController
  def index
    if params[:artist_id]
      @vinyls = Vinyl.my_vinyls(current_user).where("artist_id = ?", params[:artist_id])
    else
      @vinyls = Vinyl.my_vinyls(current_user)
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
    @artist = Artist.find(params[:vinyl][:artist_id])
    @vinyl = current_user.vinyls.new(vinyl_params)
    @artist.vinyls << @vinyl
    if @vinyl.save
      redirect_to vinyl_path(vinyl)
    else
      render :new
    end
  end

  def show
    @vinyl = Vinyl.find(params[:id])
  end

  def edit
    @vinyl = Vinyl.find(params[:id])
  end

  def update
    vinyl = current_user.vinyls.update(vinyl_params)
    redirect_to vinyl_path(vinyl)
  end

  def delete
  end

  private

  def vinyl_params
    params.require(:vinyl).permit(:title, :price, :inventory, :artist_id, genre_ids:[], genres_attributes: [:name], artist_attributes: [:name])
  end
end
