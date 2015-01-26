class Event < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :photos, as: :imageable
  accepts_nested_attributes_for :photos
  default_scope -> { order('date_time DESC') }
  validates :event_type, presence: true
  validates :date_time, presence: true
  validates :title, presence: true
end


#class UsersEvents < ActiveRecord::Migration
#  def change
#    create_table :users_events, :id => false do |t|
#      t.integer :user_id
#      t.integer :event_id
#    end
#  end
#end
