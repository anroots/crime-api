desc 'Save online usernames'
task :save_online_users => :environment do

  require 'pages/online_list'
  online = OnlineList.new.parse

  # Save unique usernames
  if online.count
    online.each do |user|
      unless OnlinePlayer.find_by_username(user[0])
        OnlinePlayer.new.update({:username => user[0], :world => user[1]})
      end
    end
  end

end