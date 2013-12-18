class PlayersController < ApplicationController

  def index

    @player = Player.where({username: params[:username],world: params[:world]})

    if @player.blank?
      @player = Player.new({username: params[:username],world: params[:world]})
      @player.remote_load
    end

    render json: @player
  end

end
