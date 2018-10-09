class Note < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :iine_users, through: :likes, source: :user
  default_scope -> {order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id , presence: true
  validates :content,  presence: true
  validates :title, presence: true
  validate :picture_size
  
  def iine(user)
    likes.create(user_id: user.id)
  end
  
  def uniine(user)
    likes.find_by(user_id: user.id).destroy
  end
  
  def iine?(user)
    iine_users.include?(user)
  end
  
 
  
  private
  
  
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
  

  
  
end
