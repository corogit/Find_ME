class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @pets = @user.pets.page(params[:page]).per(1)
    @comment = Comment.new
    @comments = Comment.all

    @current_user_entry = Entry.where(user_id: current_user.id)
    @user_entry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @current_user_entry.each do |cu|
        @user_entry.each do |u|
          if cu.room_id == u.room_id
            @is_room = true
            @room_id = cu.room_id
          end
        end
      end

      unless @is_room
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

  # 退会処理
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
    # @userがフォローしているユーザー
    @user  = User.find(params[:id])
    @users = @user.followings
  end

  def followers
    # @userをフォローしているユーザー
    @user  = User.find(params[:id])
    @users = @user.followers
    @pet = @user.pets
  end

  private

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(@user.id)
    end
  end

  def user_params
    params.require(:user).permit(
      :last_name, :first_name,
      :last_name_kana, :first_name_kana,
      :email, :zipcode, :address, :phone_number,
      :profile_image, :introduction, :followers, :follower
    )
  end
end
