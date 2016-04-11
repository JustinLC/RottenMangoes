class Admin::UsersController < ApplicationController
	
	before_action :check_admin

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			redirect_to admin_user_path(@user)
		else
			render :edit
		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		UserMailer.destroy_email(@user).deliver_later
		redirect_to admin_users_path
	end

	protected

	def check_admin
    if !current_user.nil? && !current_user.admin
      redirect_to movies_path
    end
  end

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end

end
