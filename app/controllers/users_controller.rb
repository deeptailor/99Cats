class UsersController < ApplicationController
  before_action :block_sign_in , only: [:new]

  def new
    @url = users_url
  end

  def show
    redirect_to cats_url
  end

  def create
    user = User.new(user_name: user_params[:user_name])
    user.password = user_params[:password]
    if user.save
      login!(user)
      redirect_to user_url(user)
    else
      flash[:errors] = user.errors.full_messages
      redirect_to new_user_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end

  def block_sign_in
    redirect_to cats_url if current_user
  end
end
