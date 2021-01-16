class UsersController < ApplicationController
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @pets = @user.pets.page(params[:page]).per(1)
    @comment = Comment.new
    @comments = Comment.all
   
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end

      unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end
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
    params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :zipcode, :address, :phone_number, :profile_image, :introduction, :followers, :follower)
  end

end
