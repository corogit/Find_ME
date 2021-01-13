class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @pets = @user.pets
    @comment = Comment.new
    @comments = Comment.all
  end

  def edit
    @user = current_user.id
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
    
  #退会処理 
  def unsubscribe
    @user = User.find(params[:id])
  end

  def withdraw
    @user = User.find(params[:id])
    if @user.update(is_deleted: true)
      reset_session
      redirect_to root_path
    end
  end
  
  def followings
    #@userがフォローしているユーザー
    @user  = User.find(params[:id])
    @users = @user.followings
    
  end

  def followers
    #@userをフォローしているユーザー
    @user  = User.find(params[:id])
    @users = @user.followers
    @pet = @user.pets
  end
  
  private
  def user_params
    params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :zipcode, :address, :phone_number, :profile_image, :followers, :follower)
  end

end
