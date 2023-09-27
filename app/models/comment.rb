class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :context, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["context", "created_at", "id", "post_id", "updated_at", "user_id"]
  end
end
