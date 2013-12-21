class PlayersController < ApplicationController

  def index

    # Require API key
    unless params.has_key?('api_key') and params[:api_key] == 'demo'
      render json: {response: 'API key invalid'}, :status => :unauthorized
      return
    end

    require 'pages/public_profile'

    begin
      player = PublicProfile.new(params[:world], params[:username])
      render json: player.parse
    rescue ArgumentError
      render json: {response: 'User Not Found!'}, :status => :not_found
    end

  end

end
