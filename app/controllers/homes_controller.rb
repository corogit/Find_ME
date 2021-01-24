class HomesController < ApplicationController
  def top
    @genres = Genre.all
    @random = Pet.order("RANDOM()").limit(4)
  end

  def about
  end
end
