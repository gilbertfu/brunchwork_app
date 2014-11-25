class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :school
      t.string :work_position
      t.string :company

      t.timestamps
    end
  end
end
