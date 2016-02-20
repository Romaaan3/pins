class CommentsController < ApplicationController
 before_action :find_pin
  before_action :find_comment, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  def create
    @comment = @pin.comments.create(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to pin_path(@pin)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to pin_path(@pin)
    else
      render 'edit'
    end
  end

  def destroy
    @comment.destroy
    redirect_to pin_path(@pin)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_pin
    @pin = Pin.find(params[:pin_id])
  end

  def find_comment
    @comment = @pin.comments.find(params[:id])
  end

end
