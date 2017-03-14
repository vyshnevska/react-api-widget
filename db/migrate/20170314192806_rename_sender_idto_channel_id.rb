class RenameSenderIdtoChannelId < ActiveRecord::Migration
  def change
    rename_column :messages, :sender_id, :channel_id
  end
end
