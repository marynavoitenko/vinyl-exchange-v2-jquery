class ArtistsController < ApplicationController
  def show
    @artist = Artist.find(params[:id])
    @vinyl = @artist.vinyls.build
  end
end
