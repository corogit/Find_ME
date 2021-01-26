class HomesController < ApplicationController
  def top
    @genres = Genre.all

    if Rails.env.production?
      @random = Pet.order("rand()").limit(4)
    else
      @random = Pet.order("RANDOM()").limit(4)
    end
  end

  def about
  end
end
