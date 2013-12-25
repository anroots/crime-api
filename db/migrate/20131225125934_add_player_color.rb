class AddPlayerColor < ActiveRecord::Migration
  def change
    add_column :online_players, 'activity', :float, default: 0
    add_column :online_players, 'color', :string, default: '666666'
  end
end
