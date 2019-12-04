class PlaysController < ApplicationController
  def index
  end

  def new
    @play = Play.new
  end

  def create
    @play = Play.new(play_params)

    if @play.save
      redirec_to root_path
    else
      render 'new'
    end
  end

  private

  def play_params
    params.require(:play).permit(:title, :description, :director)
  end
end
