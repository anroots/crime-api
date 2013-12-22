class PlayersController < ApplicationController

  before_action do
    # Require API key
    unless params.has_key?('api_key') and params[:api_key] == 'demo'
      render json: {response: 'API key invalid'}, :status => :unauthorized
    end
  end

  def index
    require 'pages/public_profile'

    begin
      player = PublicProfile.new(params[:world], params[:username])
      render json: player.parse
    rescue ArgumentError
      render json: {response: 'User Not Found!'}, :status => :not_found
    end

  end

  # List all players by world
  def all

    players = OnlinePlayer.uniq.find_all

    usernames = {}
    players.each do |player|

      unless usernames.has_key?(player.world)
        usernames[player.world] = []
      end

      usernames[player.world].push(player.username)
    end

    render json: usernames
  end

end
