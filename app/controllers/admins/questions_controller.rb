class Admins::QuestionsController < ApplicationController
  load_and_authorize_resource
  before_action :load_sources, only: :new

  def new
    @question.answers.build
    @question_form = QuestionForm.new @question
  end

  def create
    params[:question][:answers_attributes].each do |_, value|
      @question.answers.build
    end
    @question_form = QuestionForm.new @question
    if @question_form.validate params[:question].permit!
      @question_form.save
      flash[:success] = t "question.add_success"
      redirect_to admin_questions_path
    else
      flash.now[:danger] = t "question.add_fail"
      load_sources
      render :new
    end
  end

  private
  def question_params
    params.require(:question).permit :content, :question_type, :subject_id
  end

  def load_sources
    @question_types = Question.question_types
    @subjects = Subject.all
  end
end
