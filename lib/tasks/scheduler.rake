desc 'Save online usernames'
task :save_online_users => :environment do

  require 'pages/online_list'
  online = OnlineList.new.parse

  # Save unique usernames
  if online.count
    online.each do |username|
      OnlinePlayer.new.update({:username => username}) unless OnlinePlayer.find_by_username(username)
    end
  end

  puts online
end