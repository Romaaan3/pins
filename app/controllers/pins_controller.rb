class PinsController < ApplicationController

  before_action :find_pin, only: [:show, :edit, :update, :destroy, :upvote, :unvote]
  before_action :authenticate_user!, except: [:index, :show]
  rescue_from ActiveRecord::RecordNotFound, with: :pin_not_found

  def index
    @pins = Pin.all.order("created_at DESC")
  end

  def show

  end

  def new
    @pin = current_user.pins.build
  end

  def create
    @pin = current_user.pins.build(pin_params)

    if @pin.save
      redirect_to @pin, notice: "Successfully created new Pin"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @pin.update(pin_params)
      redirect_to @pin, notice: "Pin wass successfully updated"
    else
      render 'edit'
    end
  end

  def destroy
    @pin.destroy
    redirect_to root_path
  end

  def upvote
    @pin.liked_by current_user
    respond_to do |format|
    format.html { redirect_to :back }
    format.js
  end
  end

  def unvote
    @pin.unliked_by current_user
    respond_to do |format|
    format.html { redirect_to :back }
    format.js
  end
  end

  def show_my
    @pins = Pin.where(["user_id = ?", current_user.id])
  end

  private
  def pin_params
    params.require(:pin).permit(:title, :description, :image)
  end

  def find_pin
    @pin = Pin.find(params[:id])
  end

  def pin_not_found
    logger.error "Attempt to access a non-existent pin #{params[:id]}"
    redirect_to root_path, notice: 'Pin not found'
  end

end
