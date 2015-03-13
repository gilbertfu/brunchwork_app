class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string    :title
      t.string    :about
      t.string    :event_type
      t.string    :location
      t.string    :url
      t.string    :image
      t.integer   :attendees
      t.integer   :max_attendees
      t.datetime  :date_time
      t.string    :status
      t.integer   :event_id, :limit => 8
      t.timestamps
    end
    add_index :events, [:date_time]
  end
end
