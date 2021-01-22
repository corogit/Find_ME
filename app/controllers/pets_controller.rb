class PetsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

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
    @genres = Genre.all
    @pets = Pet.page(params[:page]).reverse_order
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

  def search
    @search_params = pet_search_params  #検索結果の画面で、フォームに検索した値を表示するために、paramsの値をビューで使えるようにする
    @pets = Pet.search(@search_params) #{.includes(:genre)}←なしで行けたよ？why  #Reservationモデルのsearchを呼び出し、引数としてparamsを渡している。
  end

  private

  def pet_search_params
    params.fetch(:search, {}).permit(:prefecture_id, :birthday_from, :birthday_to, :gender, :genre_id)
    #fetch(:search, {})と記述することで、検索フォームに値がない場合はnilを返し、エラーが起こらなくなる
    #ここでの:searchには、フォームから送られてくるparamsの値が入っている
  end

  # private

  def ensure_correct_user
    @pet = Pet.find(params[:id])
    unless @pet.user == current_user
      redirect_to pets_path
    end
  end

  def pet_params
    params.require(:pet).permit(:name, :image, :birthday, :gender, :introduction, :genre_id, :prefecture_id, :age, :is_active)
  end

end
