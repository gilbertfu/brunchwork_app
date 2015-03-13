class AddUserIdColumnToEmployments < ActiveRecord::Migration
  def change
    add_column :employments, :user_id, :integer
  end
end
