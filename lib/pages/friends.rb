class Friends


  def initialize(world, username)
    @world, @username = world, username
    @page = Nokogiri::HTML(RestClient.get(base_url))
  end

  def base_url
    'http://www.crime.ee/index.php?a=11&m={world}&k={username}&l=2'.gsub('{world}', @world).gsub('{username}', Rack::Utils.escape(@username))
  end


  def parse
    rows = @page.xpath('//*[@id="centerbar"]/div/table/tr')

    users = []
    rows.collect do |row|
      unless row.at_css('a')
        next
      end

      username = row.css('a').text.to_s.strip
      users.push(username) unless username.empty?
    end

    users
  end


end