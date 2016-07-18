class Result < ActiveRecord::Base
  belongs_to :exam
  belongs_to :question
  belongs_to :answer

  has_one :text_answer, dependent: :destroy

  scope :correct, ->{where is_correct: true}

  accepts_nested_attributes_for :text_answer

  after_create :create_text_answer

  private
  def create_text_answer
    TextAnswer.create if question.text?
  end
end
