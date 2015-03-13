class CreateEmployments < ActiveRecord::Migration
  def change
    create_table :employments do |t|
      t.text :company
      t.text :title
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
