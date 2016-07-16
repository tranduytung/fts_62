class Question < ActiveRecord::Base
  belongs_to :subject

  has_one :suggested_question, dependent: :destroy

  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy

  enum question_type: [:single_choice, :multiple_choice, :text]
  enum status: [:waiting, :approved, :rejected]

  scope :random, ->{order "RANDOM()"}
end
