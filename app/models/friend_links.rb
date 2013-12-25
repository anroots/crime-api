class FriendLinks < ActiveRecord::Base
  belongs_to :from_node, :foreign_key => 'from_id', :class_name => 'OnlinePlayer'
  belongs_to :to_node, :foreign_key => 'to_id', :class_name => 'OnlinePlayer'
end
