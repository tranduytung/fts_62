class Users::ExamsController < ApplicationController
  before_action :authenticate_user!
  authorize_resource
  load_resource except: :show

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

  def show
    @exam = Exam.includes({results: [{question: :answers}, :text_answer]}).
      find_by id: params[:id]
    @subject = @exam.subject
    if @exam.start?
      @exam.update_attributes started_at: Time.zone.now
      @exam.testing!
    end
    @remaining_time = @exam.remaining_time
  end

  def create
    @subject = Subject.find_by id: params[:exam][:subject_id]
    if @subject.present?
      @exam = current_user.exams.build exam_params
      if @exam.save
        flash[:success] = t "exam.created"
      else
        flash[:danger] = t "exam.not_created"
      end
    else
      flash[:danger] = t "exam.subject_not_found"
    end
    redirect_to users_exams_path
  end

  def update
    if @exam.update_attributes exam_params
      @exam.update_attributes spent_time: @exam.calculated_spent_time
      if @exam.time_out? || params[:finish]
        @exam.unchecked!
      end
      flash[:notice] = t "exam.submit_success"
    else
      flash[:alert] = t "exam.invalid"
    end
    redirect_to users_exams_url
  end

  private
  def exam_params
    params.require(:exam).permit :subject_id,
      results_attributes: [:id, :answer_id, answer_ids: [],
      text_answer_attributes: [:id, :content]]
  end
end
