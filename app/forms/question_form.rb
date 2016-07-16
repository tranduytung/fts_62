class QuestionForm < Reform::Form
  include Reform::Form::ActiveModel
  include Reform::Form::ModelReflections

  model :question, on: :question

  property :content
  property :question_type
  property :subject_id
  validates :content, presence: true

  collection :answers do
    property :id, writeable: false
    property :content
    property :is_correct
    property :_destroy, writeable: false
  end

  def save
    super do |attrs|
      to_be_removed = ->(i) {i[:_destroy] == "1"}
      task_ids_to_rm = attrs[:answers].select(&to_be_removed).map {|i| i[:_destroy]}
      answers.reject! {|i| task_ids_to_rm.include? i._destroy}
      answers.reject! {|i| i.content.blank?}
    end
    super
  end
end
