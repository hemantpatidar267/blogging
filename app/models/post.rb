class Post < ApplicationRecord
  has_one_attached :blog_pic
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :tittle, :context, presence: true


  def self.ransackable_attributes(auth_object = nil)
    ["context", "created_at", "id", "tittle", "updated_at", "user_id", "blog_pic"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["comments", "user"]
  end

  self.per_page = 2
end
