class PublicProfile

  BASE_URL = 'http://crime.ee/index.php?a=11&m={world}&k={user}'
  YES = 'jah'

  def initialize(world, username)
    @username, @world = username, world
    @page = Nokogiri::HTML(RestClient.get(PublicProfile.profile_url(world, username)))


    if @page.at_xpath('//*[@id="message-container"]/p')
      puts @page.text
      raise ArgumentError, 'User not found'
    end

  end

  # Extract Xpath val from the page and convert to type
  def get_val(xpath, type)
    case type
      when 'int'
        @page.xpath(xpath).text.to_s.gsub(/[[:space:]]/, '').to_i
      when 'bool'
        @page.xpath(xpath).text.strip.downcase == YES
      else
        @page.xpath(xpath).text.strip
    end
  end

  # Recursively extract data data from the page as defined by the config item
  def parse_item(item)

    # Extract from page
    if item.has_key?('path')
      return get_val(item['path'], item['type'])
    end

    # Dealing with a nested item here
    g1 = {}
    item.each do |v1, item|
      g1[v1] = parse_item(item)
    end
    g1

  end

  # Extract values from the page
  def parse

    values = {}

    # Items are defined in the config file
    paths = YAML.load_file('config/paths.yml')

    paths.each do |key, item|
      values[key] = parse_item(item)
    end

    # Additional values
    values['account'].merge!({
                                world: @world,
                                username: @username,
                                profile_url: PublicProfile.profile_url(@world, @username)
                            })

    values
  end

  # Full profile URL for crime.ee
  def self.profile_url(world, username)
    BASE_URL.gsub('{world}', world).gsub('{user}', Rack::Utils.escape(username))
  end


end
