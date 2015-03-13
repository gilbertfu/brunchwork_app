class Employment < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :company, presence: true, length: { maximum: 40 }
  validates :title, presence: true, length: { maximum: 40 }
  default_scope -> { order('start_date DESC') }
end
