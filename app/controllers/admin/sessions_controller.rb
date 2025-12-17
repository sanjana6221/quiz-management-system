module Admin
  class SessionsController < ApplicationController
    layout "application"

    def new
      @admin_user = AdminUser.new
    end

    def create
      @admin_user = AdminUser.find_by(email: params[:admin_user][:email])
      if @admin_user&.authenticate(params[:admin_user][:password])
        session[:admin_user_id] = @admin_user.id
        redirect_to admin_root_path, notice: "Logged in successfully"
      else
        flash.now[:alert] = "Invalid email or password"
        @admin_user = AdminUser.new(email: params[:admin_user][:email])
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      reset_session
      redirect_to admin_login_path, notice: "Logged out"
    end

    private

    def session_params
      params.require(:admin_user).permit(:email, :password)
    end
  end
end
