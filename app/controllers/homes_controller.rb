class HomesController < ApplicationController
  def top
    @genres = Genre.all

    if Rails.env.production?
      @random = Pet.where(:is_active => true).order("rand()").limit(4)
    else
      @random = Pet.where(:is_active => true).order("RANDOM()").limit(4)
    end
  end

  def about
  end
end
