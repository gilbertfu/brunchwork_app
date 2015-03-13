class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.string :school
      t.string :degree
      t.string :major
      t.date :grad_year

      t.timestamps
    end
  end
end
