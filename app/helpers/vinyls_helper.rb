module VinylsHelper
  def add_new_vinyl
    if @artist
      new_artist_vinyl_path(@artist, @artist.vinyls.build)
    else
      new_vinyl_path
    end
  end
end
