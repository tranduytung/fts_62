class Users::CallbacksController < Devise::OmniauthCallbacksController
  class << self
    def provides_callback_for provider
      class_eval %Q{
        def #{provider}
          @user = User.from_omniauth request.env["omniauth.auth"]
          if @user.persisted?
            flash[:success] = t("devise.omniauth_callbacks.success",
              kind: "#{provider}".capitalize)
            sign_in_and_redirect @user
          else
            session["devise.user_attributes"] = @user.attributes
            flash[:notice] = t "user.complete_registration"
            redirect_to new_user_registration_path
          end
        end
      }
    end
  end

  [:github].each do |provider|
    provides_callback_for provider
  end
end
