class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :about
      t.string :event_type
      t.string :location
      t.datetime :date_time

      t.timestamps
    end
    add_index :events, [:date_time]
  end
end
