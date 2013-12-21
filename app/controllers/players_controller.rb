class PlayersController < ApplicationController

  def index

    require 'pages/public_profile'

    begin
      player = PublicProfile.new(params[:world], params[:username])
      render json: player.parse
    rescue ArgumentError
      render json: {response: 'User Not Found!'}, :status => :not_found
    end

  end

end
