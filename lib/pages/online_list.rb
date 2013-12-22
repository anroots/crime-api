class OnlineList

  BASE_URL = 'http://crime.ee/index.php?a=7'

  def initialize
    @page = Nokogiri::HTML(RestClient.get(BASE_URL))
  end

  # Get a list of online users from the White world
  def parse

    rows = @page.xpath('//*[@id="centerbar"]/div[2]/table/tr/td[1]/table/tr')

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
