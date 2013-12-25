class FriendsGraphController < ApplicationController
  def index
  end

  def gexf
    @players = OnlinePlayer.all
    render :template => 'friends_graph/gexf', :formats => [:xml], :handlers => :builder, :layout => false
  end
end
