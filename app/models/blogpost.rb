class Blogpost < ActiveRecord::Base
  has_many :photos, as: :imageable
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :photos
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true
  validates :title, presence: true
end
