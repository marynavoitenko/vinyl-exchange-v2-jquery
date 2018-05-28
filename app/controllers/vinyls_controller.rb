class VinylsController < ApplicationController
  def index
    if params[:artist_id]
      @vinyls = Vinyl.all.where("artist_id = ?", params[:artist_id])
    else
      @vinyls = Vinyl.all
    end

    respond_to do |f|
      f.html { render :index }
      f.json { render json: @vinyls }
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

    if @vinyl.save
      redirect_to vinyl_path(@vinyl)
    else
      render :new
    end
  end

  def show
    @vinyl = Vinyl.find(params[:id])
    respond_to do |f|
      f.html { render :show }
      f.json { render json: @vinyl }
    end
  end

  def edit
    @vinyl = current_user.vinyls.find_by(id: params[:id])
    if !@vinyl
      redirect_to vinyls_path
    end
  end

  def update
    @vinyl = current_user.vinyls.find(params[:id])

    @vinyl.update(vinyl_params)

    if @vinyl.save
      redirect_to vinyl_path(@vinyl)
    else
      render :edit
    end
  end

  def destroy
    Vinyl.find(params[:id]).destroy
    redirect_to my_vinyls_path
  end

  def my_vinyls
    @vinyls = Vinyl.my_vinyls(current_user)
    respond_to do |f|
      f.html { render :index }
      f.json { render json: @vinyls }
    end
  end

  def next
    @vinyl = Vinyl.find(params[:id])
    render json: @vinyl.next
  end

  private

  def vinyl_params
    params.require(:vinyl).permit(:title, :price, :inventory, :for_sale, :artist_id, genre_ids:[], genres_attributes: [:name], artist_attributes: [:name])
  end
end
