class Users::ExamsController < ApplicationController
  load_and_authorize_resource

  def index
    @exams = current_user.exams.page(params[:page]).per Settings.exam.per_page
    @subjects = Subject.all
    @exam = current_user.exams.new
  end

  def create
    @exam = current_user.exams.new exam_params
    if @exam.save
      flash[:success] = t "subject.add_success"
      redirect_to users_exams_path
    else
      flash[:danger] = t "subject.add_fail"
      render users_exams_path
    end
  end

  private
  def exam_params
    params.require(:exam).permit :subject_id
  end
end
