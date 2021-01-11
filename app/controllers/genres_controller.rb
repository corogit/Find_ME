class GenresController < ApplicationController
  
  def index
    @genre = Genre.new
    @genres = Genre.all
  end
  
  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to genres_path
    end
  end
  
  
  private
def genre_params
  params.require(:genre).permit(:name, :is_active)
end


end