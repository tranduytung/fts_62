class Admins::SuggestedQuestionsController < ApplicationController
  load_and_authorize_resource

  def index
    @subjects = Subject.all
    @search = @suggested_questions.ransack params[:q]
    @statuses = Question.statuses
    @suggested_questions = if params[:q].nil?
      @suggested_questions.page(params[:page]).
        per Settings.admin.suggested_question.per_page
    else
      @search.result.page(params[:page]).
        per Settings.admin.suggested_question.per_page
    end
  end

  def edit
  end

  def update
    question_status = params[:action_type]
    if @suggested_question.question.update_attributes status: question_status
      flash[:success] = t "suggested_question.edit_success",
        action: t(question_status)
      redirect_to admins_suggested_questions_path
    else
      flash[:danger] = t "suggested_question.edit_failed",
        action: t(question_status)
      render :edit
    end
  end
end
