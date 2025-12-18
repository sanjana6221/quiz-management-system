module Admin
  class SessionsController < ApplicationController
    layout "application"

    # GET /admin/login
    def new
      @admin_user = AdminUser.new
    end

    # POST /admin/sessions
    def create
      @admin_user = AdminUser.find_by(email: session_params[:email])

      if @admin_user&.authenticate(session_params[:password])
        session[:admin_user_id] = @admin_user.id
        redirect_to admin_root_path, notice: "Logged in successfully"
      else
        flash.now[:alert] = "Invalid email or password"
        @admin_user = AdminUser.new(email: session_params[:email])
        render :new, status: :unprocessable_entity
      end
    end

    # DELETE /admin/logout
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
