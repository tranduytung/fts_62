class Exam < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject

  has_many :results, dependent: :destroy

  enum status: [:start, :testing, :unchecked, :checked]
  validate :check_number_question

  after_create :create_result_for_exam

  accepts_nested_attributes_for :results

  def calculated_score
    results.correct.count
  end

  private
  def check_number_question
    errors.add :base, I18n.t("subject.not_enought_question") if
      subject.number_of_questions > subject.questions.count
  end

  def create_result_for_exam
    Result.transaction do
      begin
        subject.questions.approved.random.limit(
          subject.number_of_questions).each do |question|
          question.results.create exam: self
        end
      rescue
        raise ActiveRecord::Rollback
      end
    end
  end
end
