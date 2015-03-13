class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :name
      t.text :email
      t.text :school
      t.text :work_position
      t.text :company

      t.timestamps
    end
  end
end
