class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.integer :recipient_id
      t.string :status
      t.integer :sender_id

      t.timestamps null: false
    end
  end
end
