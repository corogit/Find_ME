class PetsController < ApplicationController
  
  def new
    @pet = Pet.new
    @genres = Genre.all
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.user_id = current_user.id
    if @pet.save
      redirect_to pets_path
    else
      @genres = Genre.all
      render :new
    end
  end

  def index
    @pets = Pet.all
    
  end

  def show
    @pet = Pet.find(params[:id])
  end
  
  def edit
    @pet = Pet.find(params[:id])
    @genres = Genre.all
  end
  
  def update
    @pet = Pet.find(params[:id])
    if @pet.update(pet_params)
      redirect_to pet_path
    else
      @genres = Genre.all
      render :edit
    end
  end

  def destroy
  end
  
  private

  def pet_params
    params.require(:pet).permit(:name, :image, :birthday, :gender, :introduction, :genre_id, :user_id)
  end

end
