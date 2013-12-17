class Player < ActiveRecord::Base

  def remote_load
    require 'pages/public_profile'
    profile = PublicProfile.new(self.username)
    self.update(profile.parse)
    self.save
  end
end
