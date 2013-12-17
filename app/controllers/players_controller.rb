class PlayersController < ApplicationController

  def show

    @player = Player.find_by_id(params[:id])

    if @player.blank?
      @player = Player.new({username: params[:username]})
      @player.remote_load
    end

    render json: @player
  end

end
