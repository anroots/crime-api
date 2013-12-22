class CreateOnlinePlayers < ActiveRecord::Migration
  def change
    create_table :online_players do |t|
      t.column 'username', :string
      t.column 'world', :string, :default => 'valge'
      t.timestamps
    end
  end
end
