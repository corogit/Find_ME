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
    @user = current_user
  end

  def show
    @pet = Pet.find(params[:id])
    @user = current_user
    @comment = Comment.new
    @comments = Comment.all
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
    @pet = Pet.find(params[:id])
    @pet.destroy
    redirect_to pets_path
  end
  
  private

  def pet_params
    params.require(:pet).permit(:name, :image, :birthday, :gender, :introduction, :genre_id)
  end

end
