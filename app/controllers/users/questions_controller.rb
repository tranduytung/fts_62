class Users::QuestionsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource except: [:index, :create]
  before_action :load_sources, only: [:new, :edit]
  before_action :load_question_form, only: [:edit, :update]

  def new
    @question.answers.build
    load_question_form
  end

  def index
    @questions = current_user.questions.page(params[:page]).
      per Settings.admin.suggested_question.per_page
  end

  def create
    @question = Question.new
    params[:question][:answers_attributes].each do |_, value|
      @question.answers.build
    end
    load_question_form
    if @question_form.validate params[:question].permit!
      @question_form.save
      @question_form.create_author current_user
      flash[:success] = t "question.add_success"
      redirect_to users_questions_path
    else
      flash.now[:danger] = t "question.add_fail"
      load_sources
      render :new
    end
  end

  def update
    if @question_form.validate params[:question].permit!
      @question_form.save
      flash[:success] = t "question.edit_success"
      redirect_to users_questions_path
    else
      flash.now[:danger] = t "question.edit_fail"
      load_sources
      render :edit
    end
  end

  def destroy
    if @question.destroy
      flash[:success] = t "question.delete_success"
    else
      flash.now[:danger] = t "question.delete_fail"
    end
    redirect_to users_questions_path
  end

  private
  def load_sources
    @question_types = Question.question_types
    @subjects = Subject.all
  end

  def load_question_form
    @question_form = QuestionForm.new @question
  end
end
