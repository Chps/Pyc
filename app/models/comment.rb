class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :image

  default_scope -> { order('created_at DESC') }

  validates :content, presence: true, length: { maximum: 500 }
  validates :user_id, presence: true
  validates :image_id, presence: true
end
