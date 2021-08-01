class CreateFriendRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :friend_requests do |t|
      t.references :requestor, null: false, foreign_key: { to_table: :users }
      t.references :receiver, null: false, foreign_key: { to_table: :users }
      t.integer :status

      t.timestamps
    end
  end
end
