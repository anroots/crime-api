class AddPlayerFameColumn < ActiveRecord::Migration
  def change
    add_column :online_players, 'fame', :integer, default: 0
  end
end
