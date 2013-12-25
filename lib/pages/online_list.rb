class OnlineList

  BASE_URL = 'http://crime.ee/index.php?a=7'

  def initialize
    @page = Nokogiri::HTML(RestClient.get(BASE_URL))
  end

  # Get a list of online users from the White world
  def parse

    results = []

    {:valge => '//*[@id="centerbar"]/div[2]/table/tr/td[1]/table/tr',
     :sinine => '//*[@id="centerbar"]/div[2]/table/tr/td[2]/table/tr',
     :world1 => '//*[@id="centerbar"]/div[2]/table/tr/td[3]/table/tr',
     :world2 => '//*[@id="centerbar"]/div[2]/table/tr/td[4]/table/tr'}.each do |world, xpath|
      rows = @page.xpath(xpath)
      parse_rows(rows).each do |username|
        results.push([username, world])
      end
    end

    results
  end

  def parse_rows(rows)
    users = []
    rows.collect do |row|

      if row.at_css('th')
        next
      end

      username = row.css('a').text.to_s.strip
      users.push(username) unless username.empty?
    end
    users
  end


end
