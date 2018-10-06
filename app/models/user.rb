class User < ApplicationRecord
  has_many :notes, dependent: :destroy
  #能動的関係はフォローした人のidでmodelの関係性を保つ A→B A→C の場合Aのfollower_idを用いることで関係性が作成できる
  has_many :active_relationships,  class_name:  "Relationship",
                                   foreign_key: "follower_id",
                                   dependent:   :destroy
  #受動的関係はフォローされている人のidで関係性を持つ B→A C→A　の場合BCがフォローしている人（A)のidを用いる
   has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower #throughを用いることでfollowing_idが使えるようになる(ユーザーがフォローしている集合体)
  before_save {self.email=email.downcase}
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence:true, length: {minimum:6},allow_nil:true

  
  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    Note.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end
  
  
  
  #user follow
  def follow(other_user)
    following << other_user
  end
  
  #user unfollow
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
  
  #return true if user following now user
  def following?(other_user)
    following.include?(other_user)
  end
  
  
end
