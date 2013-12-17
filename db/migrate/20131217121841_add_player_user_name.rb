class AddPlayerUserName < ActiveRecord::Migration
  def change
    add_column :players, 'username', :string, null: true, default: :null
  end
end
