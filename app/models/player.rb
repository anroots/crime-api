class Player < ActiveRecord::Base

  @profle_url = ''


  def profile_url
    PublicProfile.get_profile_url(self.world,self.username)
  end

  def remote_load
    require 'pages/public_profile'
    profile = PublicProfile.new(self.username, self.world)
    self.update(profile.parse)
    self.save
  end
end
