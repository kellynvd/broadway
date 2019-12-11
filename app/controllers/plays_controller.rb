class PlaysController < ApplicationController
  before_action :find_play, only: %i[show edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]

  def index
    if params[:category].blank?
      @plays = Play.all.order('created_at DESC')
    else
      @category_id = Category.find_by(name: params[:category]).id
      @plays = Play.where(category_id: @category_id).order('created_at DESC')
    end
  end

  def show
  end

  def new
    @play = current_user.plays.build
    @categories = Category.all.map { |c| [c.name, c.id] }
  end

  def create
    @play = current_user.plays.build(play_params)
    @play.category_id = params[:category_id]

    if @play.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @categories = Category.all.map { |c| [c.name, c.id] }
  end

  def update
    @play.category_id = params[:category_id]

    if @play.update(play_params)
      redirect_to play_path
    else
      render 'edit'
    end
  end

  def destroy
    @play.destroy
    redirect_to root_path
  end

  private

  def play_params
    params.require(:play).permit(:title, :description, :director, :category_id)
  end

  def find_play
    @play = Play.find(params[:id])
  end

  def correct_user
    flash[:notice] = 'Access denied as you are not owner of this Pic'
    redirect_to @play if current_user != @play.user
  end
end
