class Photo < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  validates :image, presence: true
  mount_uploader :image, ImageUploader
  default_scope -> { order('created_at DESC') }
  #http://stackoverflow.com/questions/19712816/carrierwave-rails-4-and-multiple-uploads
end
