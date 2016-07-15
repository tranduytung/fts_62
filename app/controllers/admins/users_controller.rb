class Admins::UsersController < ApplicationController
  load_and_authorize_resource only: :index

  def index
    @search = @users.all.ransack params[:q]
    if params[:q].nil?
      @users = @users.page(params[:page]).per Settings.admin.user.per_page
    else
      @users = @search.result.page(params[:page]).
        per Settings.admin.user.per_page
    end
  end
end
