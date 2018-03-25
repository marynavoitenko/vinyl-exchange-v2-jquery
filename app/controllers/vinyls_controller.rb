class VinylsController < ApplicationController
  def index
    @vinyls = Vinyl.my_vinyls(current_user)
  end

  def new
    @vinyl = Vinyl.new
  end

  def create
    raise params.inspect
  end

  def edit
  end

  def update
  end

  def delete
  end
end
