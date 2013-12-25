desc 'Save online usernames'
task :save_online_users => :environment do

  require 'pages/online_list'
  require 'pages/public_profile'
  require 'rack/auth/digest/md5'

  online = OnlineList.new.parse

  # Save unique usernames
  if online.count
    online.each do |user|
      unless OnlinePlayer.find_by_username(user[0])
        profile = PublicProfile.new(user[1], user[0]).parse
        color = Digest::MD5.hexdigest(profile['gang']['name'])[0..5]
        OnlinePlayer.new.update({:username => user[0],
                                 :world => user[1],
                                 :activity => profile['stats']['activity'],
                                 :color => color,
                                 :fame => profile['stats']['fame']})
      end
    end
  end

end