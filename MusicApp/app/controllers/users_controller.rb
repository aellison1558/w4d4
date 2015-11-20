class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :activate]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to user_url(@user)
      message = Activation.activation_email(@user, activate_url(@user))
      message.deliver_now
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def activate
    @user = User.find(params[:id])
    @user.toggle(:activate)
    @user.save
    redirect_to root_url
  end

  private
  def user_params
    params[:user].permit(:email, :password, :activate)
  end
end
