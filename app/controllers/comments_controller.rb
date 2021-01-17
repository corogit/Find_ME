class CommentsController < ApplicationController
  def create
    @pet = Pet.find(params[:pet_id])
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.pet_id = @pet.id
    comment.save
    @comment = Comment.new
  end

  def destroy
    @pet = Pet.find(params[:pet_id])
    Comment.find_by(id: params[:id], pet_id: params[:pet_id]).destroy
    @comment = Comment.new
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
