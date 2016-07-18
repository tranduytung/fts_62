class Users::ExamsController < ApplicationController
  before_action :authenticate_user!
  authorize_resource

  def index
    @exam = Exam.new
    @exams = current_user.exams
    @subjects = Subject.order :content
    @statuses = Exam.statuses
    @search = @exams.ransack params[:q]
    @exams = @search.result unless params[:q].nil?
    @exams = @exams.page(params[:page]).per(Settings.exam.per_page).
      order created_at: :desc
  end

  def create
    @exam = current_user.exams.build exam_params
    if @exam.save
      flash[:success] = t "exam.created"
    else
      flash[:danger] = t "exam.not_created"
    end
    redirect_to users_exams_path
  end

  private
  def exam_params
    params.require(:exam).permit :subject_id
  end
end
