class AddGoalsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :goal, :text
  end
end
