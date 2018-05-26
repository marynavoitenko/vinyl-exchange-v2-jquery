class ArtistsController < ApplicationController
  def show
    @artist = Artist.find(params[:id])
    respond_to do |f|
      f.html { render :show }
      f.json { render json: @artist }
    end
  end
end
