class AddPlayerAttributes < ActiveRecord::Migration
  def change
    add_column :players, 'fame', :integer, default: 0
    add_column :players, 'mining', :integer, default: 0
  end
end
