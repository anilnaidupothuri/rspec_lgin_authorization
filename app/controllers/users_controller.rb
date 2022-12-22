class UsersController < ApplicationController
	before_action :set_user, only: [:show, :update, :destroy]
	before_action :check_owner, only: [:update, :destroy]

	def show 
		render json:@user
	end 

	def index 
		users = User.all 
		render json: users 
	end 

	def create 
		user = User.create(user_params)
		if user.save 
			render json: user 
		else 
			render json: user.errors 
		end 
	end 

	def update 
		if @user.update(user_params)
			render json:@user 
		else 
			render json: @user.errors 
		end 
	end 

	def destroy 
		@user.destroy 
		head :no_content
	end

	private 

	def set_user 
		@user = User.find(params[:id])
	end 

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

	def check_owner
		head :forbidden unless current_user.id == @user.id
	end
end
