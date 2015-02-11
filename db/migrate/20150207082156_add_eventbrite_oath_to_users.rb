class AddEventbriteOathToUsers < ActiveRecord::Migration
  def change
    add_column :users, :eventbrite_oath, :string
  end
end
