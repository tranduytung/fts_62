class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
    :rememberable, :trackable, :validatable

  has_many :suggested_questions, dependent: :destroy
  has_many :exams, dependent: :destroy
end
