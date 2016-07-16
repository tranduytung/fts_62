class Result < ActiveRecord::Base
  belongs_to :exam
  belongs_to :question
  belongs_to :answer

  has_one :text_answer, dependent: :destroy

  scope :correct, ->{where is_correct: true}
end
