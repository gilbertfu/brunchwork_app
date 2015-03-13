class AddActivationTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activation_token, :text
  end
end
