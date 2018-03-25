class StoreController < ApplicationController
  def index
    @genres = Genre.all
    @vinyls = Vinyl.for_sale
  end
end
