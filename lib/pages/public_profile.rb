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

  def parse_item(item)

    if item.has_key?('path')
      return get_val(item['path'], item['type'])
    end

    g1 = {}
    item.each do |v1, item|
      g1[v1] = parse_item(item)
    end
    g1
  end

  def parse

    values = {}
    paths = YAML.load_file('config/paths.yml')

    paths.each do |key, item|
      values[key] = parse_item(item)
    end

    values['account'].merge!({
                                world: @world,
                                username: @username,
                                profile_url: PublicProfile.profile_url(@world, @username)
                            })

    values
  end

  def self.profile_url(world, username)
    BASE_URL.gsub('{world}', world).gsub('{user}', Rack::Utils.escape(username))
  end


end
