class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :blogpost
  validates :content, presence: true, length: { maximum: 500 }
  
end
