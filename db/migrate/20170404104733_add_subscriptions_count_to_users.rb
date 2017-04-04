class AddSubscriptionsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subscriptions_count, :integer
  end
end
