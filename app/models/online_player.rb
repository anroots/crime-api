class OnlinePlayer < ActiveRecord::Base
  has_many :to_links, :foreign_key => 'from_id', :class_name => 'FriendLinks' #tricky!
  has_many :to_nodes, :through => :to_links

  has_many :from_links, :foreign_key => 'to_id', :class_name => 'FriendLinks' #tricky!
  has_many :from_nodes, :through => :from_links


  def add_friend(username)
    friend = OnlinePlayer.where("world = ? AND username = ?", self.world, username).first

    if friend == nil
      friend = OnlinePlayer.new
      friend.update({:username => username, :world => self.world})
    end


    unless FriendLinks.where('from_id = ? AND to_id = ?', self.id, friend.id).any?
      FriendLinks.new.update({:from_id => self.id, :to_id => friend.id})
    end
  end

end
