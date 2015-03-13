class Education < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :school, presence: true, length: { maximum: 40 }
  validates :major, length: { maximum: 30 }
  validates :degree, presence: true, length: { maximum: 20 }
  default_scope -> { order('grad_year DESC') }
end
