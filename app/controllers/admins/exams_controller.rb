class Admins::ExamsController < ApplicationController
  load_and_authorize_resource

  def index
    @subjects = Subject.all
    @statuses = Exam.statuses
    @search = @exams.ransack params[:q]
    @exams = if params[:q].nil?
      @exams.page(params[:page]).per Settings.exam.per_page
    else
      @search.result.page(params[:page]).per Settings.exam.per_page
    end
  end
end
