class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.text :school
      t.text :degree
      t.text :major
      t.date :grad_year

      t.timestamps
    end
  end
end
