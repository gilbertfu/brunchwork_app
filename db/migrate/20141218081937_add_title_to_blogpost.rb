class AddTitleToBlogpost < ActiveRecord::Migration
  def change
    add_column(:blogposts, :title, :text)
  end
end
