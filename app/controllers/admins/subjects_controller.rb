class Admins::SubjectsController < ApplicationController
  load_and_authorize_resource except: [:destroy, :index, :show]

  def create
    if @subject.save
      flash[:success] = t "subject.add_success"
      redirect_to admins_subjects_path
    else
      flash[:danger] = t "subject.add_fail"
      render :new
    end
  end

  def update
    if @subject.update_attributes subject_params
      flash[:success] = t "subject.edit_success"
      redirect_to [:admins, @subject]
    else
      flash[:danger] = t "subject.edit_failed"
      render :edit
    end
  end

  private
  def subject_params
    params.require(:subject).permit :content, :number_of_questions, :duration
  end
end
