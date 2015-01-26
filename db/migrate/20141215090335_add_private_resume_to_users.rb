class AddPrivateResumeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :private_resume, :boolean
  end
end
