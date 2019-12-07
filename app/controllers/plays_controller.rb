class PlaysController < ApplicationController
  before_action :find_play, only: %i[show edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]

  def index
    @plays = Play.all.order('created_at DESC')
  end

  def show
  end

  def new
    @play = current_user.plays.build
  end

  def create
    @play = current_user.plays.build(play_params)

    if @play.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
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
    params.require(:play).permit(:title, :description, :director)
  end

  def find_play
    @play = Play.find(params[:id])
  end

  def correct_user
    flash[:notice] = 'Access denied as you are not owner of this Pic'
    redirect_to @play if current_user != @play.user
  end
end
