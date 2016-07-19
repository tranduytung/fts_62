class QuestionForm < Reform::Form
  include Reform::Form::ActiveModel
  include Reform::Form::ModelReflections

  model :question, on: :question

  property :content
  property :question_type
  property :subject_id
  validates :content, presence: true
  property :status

  collection :answers, populate_if_empty: Answer do
    property :id, writeable: false
    property :content
    property :is_correct
    property :_destroy, writeable: false
  end

  validate :validate_answer_content

  def create_author user
    user.suggested_questions.create question_id: id
  end

  def save
    super do |attrs|
      to_be_removed = -> i {i[:_destroy] == "1"}
      answer_ids_to_rm = attrs[:answers].select(&to_be_removed).map {|i| i[:_destroy]}
      answers.reject! {|i| answer_ids_to_rm.include? i._destroy}
      if model.persisted?
        answer_ids_to_rm = attrs[:answers].select(&to_be_removed).map {|i| i[:id]}
        Answer.destroy answer_ids_to_rm if answer_ids_to_rm.any?
        answers.reject! {|i| answer_ids_to_rm.include? i.id}
      end
      answers.reject! {|i| i.content.blank?}
    end
    super
  end

  private
  def validate_answer_content
    answers.each do |answer|
      if Answer.find_by_id(answer.id).present? && answer.content.blank?
        errors.add :answer, I18n.t("answer.existing_task_cant_be_blank")
      end
    end
  end
end
