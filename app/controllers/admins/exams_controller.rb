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

  def edit
  end

  def update
    if @exam.update_attributes exam_params
      flash[:success] = t "exam.check_done"
      redirect_to admins_exams_path
    else
      flash[:success] = t "exam.check_fail"
      render "edit"
    end
  end

  private
  def exam_params
    params.require(:exam).permit :status, :score,
      results_attributes: [:id, :is_correct]
  end
end
