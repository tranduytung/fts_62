class Admins::SubjectsController < ApplicationController
  load_and_authorize_resource param_method: :my_sanitizer, only: [:create, :new]

  def create
    if @subject.save
      flash[:success] = t "subject.add_success"
      redirect_to admins_subjects_path
    else
      flash[:danger] = t "subject.add_fail"
      render :new
    end
  end

  private
  def my_sanitizer
    params.require(:subject).permit :content, :number_of_questions, :duration
  end
end
