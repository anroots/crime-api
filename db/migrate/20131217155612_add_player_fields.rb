class AddPlayerFields < ActiveRecord::Migration
  def change
    add_column :players, 'world', :string
    add_column :players, 'banned', :boolean, default: false
  end
end
