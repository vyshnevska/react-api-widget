class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :channel_id
      t.integer :user_id
      t.integer :messages_count

      t.timestamps null: false
    end
  end
end
