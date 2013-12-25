class CreateFriendLinks < ActiveRecord::Migration
  def change
    create_table :friend_links do |t|
      t.column :from_id, :integer
      t.column :to_id, :integer
      t.column :value, :string
    end
  end
end
