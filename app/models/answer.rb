class Answer < ActiveRecord::Base
  belongs_to :question

  has_many :results, dependent: :destroy

  scope :correct_answers, ->{where is_correct: true}
end
