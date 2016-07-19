class Result < ActiveRecord::Base
  serialize :answer_ids, Array

  belongs_to :exam
  belongs_to :question
  belongs_to :answer

  has_one :text_answer, dependent: :destroy

  scope :correct, ->{where is_correct: true}

  accepts_nested_attributes_for :text_answer

  after_create :create_user_text_answer

  def check_result
    check = case question.question_type
    when Settings.questions.multiple_choice
      enough_correct_answers && no_incorrect_answers
    when Settings.questions.single_choice
      answer.is_correct if answer.present?
    when Settings.questions.text
      if text_answer.content
        text_answer.content.strip == question.answers.first.content.strip
      end
    end
    check ||= false
    update_attributes is_correct: check
  end

  private
  def create_user_text_answer
    create_text_answer if question.text?
  end

  def enough_correct_answers
    answer_ids.collect {|answer_id| Answer.find_by(id: answer_id).is_correct?}.
      count(true) == question.answers.correct_answers.count
  end

  def no_incorrect_answers
    answer_ids.count == question.answers.correct_answers.count
  end
end
