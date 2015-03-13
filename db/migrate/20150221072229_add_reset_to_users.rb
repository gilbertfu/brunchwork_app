class AddResetToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reset_digest, :text
    add_column :users, :reset_token, :text
    add_column :users, :reset_sent_at, :datetime
  end
end
