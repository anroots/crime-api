class PublicProfile

  BASE_URL = 'http://crime.ee/index.php?a=11&m={world}&k={user}'
  YES = 'jah'

  def initialize(world, username)
    @username, @world = username, world
    puts PublicProfile.profile_url(world, username)
    @page = Nokogiri::HTML(RestClient.get(PublicProfile.profile_url(world, username)))


    if @page.at_xpath('//*[@id="message-container"]/p')
      puts @page.text
      raise ArgumentError, 'User not found'
    end

  end


  def parse
    values = {
          world: @world,
          username: @username,
          profile_url: PublicProfile.profile_url(@world,@username)
    }

    @numeric_values = {
        mining: '//*[@id="centerbar"]/div/table/tr[18]/td[2]/strong',
        fame:'//*[@id="centerbar"]/div/table/tr[10]/td[1]/strong'
    }

    @string_values = {
        world: '//*[@id="centerbar"]/div/table/tr[3]/td/strong',
        signup_date: '//*[@id="centerbar"]/div/table/tr[4]/td/strong',
        online_date: '//*[@id="centerbar"]/div/table/tr[5]/td/strong'
    }

    @boolean_values = {
        banned: '//*[@id="centerbar"]/div/table/tr[8]/td/strong',
        vip: '//*[@id="centerbar"]/div/table/tr[6]/td/strong',
        has_clan: '//*[@id="centerbar"]/div/table/tr[7]/td/strong'
    }


    # Numeric values
    @numeric_values.each do |key, xpath|
      values[key] = @page.xpath(xpath).text.to_s.gsub(/[[:space:]]/, '').to_i
    end

    # Strings
    @string_values.each do |key, xpath|
      values[key] = @page.xpath(xpath).text.strip
    end

    # Booleans
    @boolean_values.each do |key, xpath|
      values[key] = @page.xpath(xpath).text.strip.downcase == YES
    end

    values
  end

  def self.profile_url(world, username)
    BASE_URL.gsub('{world}', world).gsub('{user}',Rack::Utils.escape(username))
  end


end
