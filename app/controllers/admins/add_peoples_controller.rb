class Admins::AddPeoplesController < ApplicationController
  authorize_resource :user, class: User.name
  authorize_resource :admin, class: Admin.name

  def new
    @user = User.new
    @admin = Admin.new
  end

  def create
    if params.to_a[2][0] == "user"
      @user = User.new people_params
      if @user.save
        flash[:success] = t "admin.user.add_success"
        redirect_to admins_users_path
      else
        flash[:danger] = t "admin.user.add_fail"
        @admin = Admin.new
        render :new
      end
    end
    if params.to_a[2][0] == "admin"
      @admin = Admin.new people_params
      if @admin.save
        flash[:success] = t "admin.admin.add_success"
        redirect_to admins_users_path
      else
        flash[:danger] = t "admin.admin.add_fail"
        @user = User.new
        render :new
      end
    end
  end

  private
  def people_params
    params.require(:user).permit :name, :email, :chatwork_id, :password,
      :password_confirmation if params.to_a[2][0] == "user"
    params.require(:admin).permit :name, :email, :chatwork_id, :password,
      :password_confirmation if params.to_a[2][0] == "admin"
  end
end
