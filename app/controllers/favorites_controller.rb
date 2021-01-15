class FavoritesController < ApplicationController

  def create
    @pet = Pet.find(params[:pet_id])
    favorite = current_user.favorites.new(pet_id: @pet.id)
    favorite.save
  end

  def destroy
    @pet = Pet.find(params[:pet_id])
    favorite = current_user.favorites.find_by(pet_id: @pet.id)
    favorite.destroy
  end
end