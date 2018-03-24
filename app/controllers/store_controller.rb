class StoreController < ApplicationController
  def index
    @genres = Genre.all
    @vinyls = Vinyl.all
  end
end
