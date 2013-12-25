xml.instruct!
xml.gexf 'xmlns:viz' => 'http://www.gexf.net/1.1draft/viz', :xmlns => 'http://www.gexf.net/1.1draft', :version => '1.1' do
  xml.meta :lastmodifieddate => '2013-12-25' do
    xml.creator 'David'
    xml.description 'Crime user friend links'
  end
  xml.graph :type => 'static', :idtype => 'string', :defaultedgetype => 'directed' do

    xml.attributes :class => 'node', :mode => 'static' do
      xml.attribute :id => 'fame', :title => 'Fame', :type => 'integer'
      xml.attribute :id => 'activity', :title => 'Activity', :type => 'float'
      xml.attribute :id => 'world', :title => 'World', :type => 'string'
    end

    xml.nodes do
      @players.each do |player|
        xml.node :id => player.id, :label => player.username do
          xml.viz :color, :r => player.color[0..1].hex, :g => player.color[2..3].hex, :b => player.color[4..5].hex, :a => 1
          fame = (player.fame * 100 / 6999999.0 / 10.0).round(7)
          xml.viz :size, :value => fame < 0.1 ? 0.1 : fame

          xml.attvalues do
            xml.attvalue :for => 'fame', :value => player.fame
            xml.attvalue :for => 'activity', :value => player.activity
            xml.attvalue :for => 'world', :value => player.world
          end

        end
      end
    end
    xml.edges do
      @players.each do |player|
        player.to_nodes.each do |friend|
          xml.edge :id => "edge_#{player.id}_#{friend.id}", :source => player.id, :target => friend.id
        end
      end
    end
  end
end
