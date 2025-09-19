# frozen_string_literal: true

class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :likes, dependent: :destroy
  # has_many :liked_posts, through: :likes, source: :post
  has_many :posts, dependent: :destroy
  has_one_attached :image

  has_many :active_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_follows, source: :followed

  has_many :passive_follows, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_follows, source: :follower

  has_many :comments, dependent: :destroy
  

  def full_name
    "#{first_name} #{last_name}"
  end

  def follow(other_account)
    following << other_account unless self == other_account
  end

  def unfollow(other_account)
    following.delete(other_account) 
  end

  def following?(other_account)
    following.include?(other_account)
  end

  def liked?(post)
    likes.exists?(post_id: post.id)
  end
end
