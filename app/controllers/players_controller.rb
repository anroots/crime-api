class PlayersController < ApplicationController

  def index

    @player = Player.where({username: params[:username],world: params[:world]})

    if @player.blank?
      @player = Player.new({username: params[:username],world: params[:world]})

      begin
        @player.remote_load
      rescue
        render json: {response: 'User Not Found!'}, :status => :not_found
        return
      end
    end

    render json: @player[0]
  end

end
