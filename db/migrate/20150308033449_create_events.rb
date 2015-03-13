class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text    :title
      t.text    :about
      t.text    :event_type
      t.text    :location
      t.text    :url
      t.text    :image
      t.integer   :attendees
      t.integer   :max_attendees
      t.datetime  :date_time
      t.text    :status
      t.integer   :event_id, :limit => 8
      t.timestamps
    end
    add_index :events, [:date_time]
  end
end
