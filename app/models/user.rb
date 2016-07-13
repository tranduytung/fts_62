class User < ActiveRecord::Base
  has_many :suggested_questions, dependent: :destroy
  has_many :exams, dependent: :destroy
end
