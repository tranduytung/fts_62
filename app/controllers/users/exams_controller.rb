class Users::ExamsController < ApplicationController
  authorize_resource

  def index
    @exams = current_user.exams.page(params[:page]).per Settings.exam.per_page
  end
end
