class PublicProfile

  BASE_URL = 'http://crime.ee/index.php?a=11&m=world1&k='
  YES = 'JAH'

  def initialize(username)
    @username = username
    @page = Nokogiri::HTML(RestClient.get(BASE_URL + Rack::Utils.escape(@username)))
  end


  def parse
    values = {}

    @numeric_values = {
        mining: '//*[@id="centerbar"]/div/table/tr[18]/td[2]/strong',
        fame:'//*[@id="centerbar"]/div/table/tr[10]/td[1]/strong'
    }

    @string_values = {
        world: '//*[@id="centerbar"]/div/table/tr[3]/td/strong'
    }

    @boolean_values = {
        banned: '//*[@id="centerbar"]/div/table/tr[8]/td/strong'
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
      values[key] = @page.xpath(xpath).text.to_s.strip.downcase == YES
    end

    values
  end

end
