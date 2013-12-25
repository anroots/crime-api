desc 'Scan throught the list of players and save their links of friends'
task :scan_friends => :environment do

  require 'pages/friends'

  players = OnlinePlayer.all

  new_friend_counter = 0

  players.each do |player|
    friends_page = Friends.new(player.world, player.username)

    friends = friends_page.parse

    if friends.empty?
      next
    end

    print '.'
    $stdout.flush

    friends.each do |friend_username|
      player.add_friend(friend_username)
      new_friend_counter+=1
    end
  end
  puts "Added #{new_friend_counter} links"
end

