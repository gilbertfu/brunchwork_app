class CreateBlogposts < ActiveRecord::Migration
  def change
    create_table :blogposts do |t|
      t.text :content

      t.timestamps
    end
    add_index :blogposts, [:created_at]
  end
end
