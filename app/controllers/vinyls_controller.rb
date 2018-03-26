class VinylsController < ApplicationController
  def index
    @vinyls = Vinyl.my_vinyls(current_user)
  end

  def new
    @vinyl = Vinyl.new
  end

  def create
    vinyl = current_user.vinyls.create(vinyl_params)
    redirect_to vinyl_path(vinyl)
  end

  def show
    @vinyl = Vinyl.find(params[:id])
  end

  def edit
  end

  def update
  end

  def delete
  end

  private

  def vinyl_params
    params.require(:vinyl).permit(:title, :price, :inventory, :artist_id, genre_ids:[], genres_attributes: [:name], artist_attributes: [:name])
  end
end
