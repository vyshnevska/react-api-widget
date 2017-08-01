class Friendships < ActiveRecord::Migration
  def change
    create_table :friendships, id: false do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.integer :friend_id, null: false

      t.timestamps
    end
  end
end