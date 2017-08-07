class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :answers, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :votes
  has_many :comments

  def author_of?(resource)
    resource.user_id == id
  end
end
