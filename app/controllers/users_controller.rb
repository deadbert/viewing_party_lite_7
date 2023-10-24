class UsersController < ApplicationController
  def new
  end

  def create
    params[:email] = params[:email].downcase
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash[:alert] = user.error_message
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
    @parties = @user.parties
  end

  def login_form
  end

  def login
    params[:email] = params[:email].downcase
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash[:alert] = "Incorrect email or Password"
      render :login_form
    end
  end

  def logout
    reset_session
    redirect_to "/"
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end