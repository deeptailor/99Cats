class SessionsController < ApplicationController
  before_action :block_sign_in , only: [:new]
  
  def new
    @url = session_url
  end

  def create
    user_name = user_params[:user_name]
    password = user_params[:password]

    user = User.find_by_credentials(user_name, password)

    if user
      login!(user)
      redirect_to cats_url
    else
      flash[:errors] = ['username or password incorrect']
      redirect_to new_session_url
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end

  def block_sign_in
    redirect_to cats_url if current_user
  end
end
