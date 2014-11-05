class AddUnsubscribeHashToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :unsubscribe_hash, :string
  end
end
