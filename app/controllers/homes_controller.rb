class HomesController < ApplicationController
  def top
    @genres = Genre.all
  end

  def about
  end
end
