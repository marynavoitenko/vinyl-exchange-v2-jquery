class VinylsController < ApplicationController
  def index
    @vinyls = Vinyl.my_vinyls(current_user)
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def delete
  end
end
