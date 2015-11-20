class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :activate]
  skip_before_action :require_admin, only: [:new, :create, :activate]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)

      activation_url = "#{activate_users_url}?activation_token=#{@user.activation_token}"
      message = Activation.activation_email(@user, activation_url)
      message.deliver_now

      redirect_to user_url(@user)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def activate
    @user = User.find_by(activation_token: params[:activation_token])
    @user.toggle(:activate)
    @user.save
    redirect_to root_url
  end

  private
  def user_params
    params[:user].permit(:email, :password, :activate)
  end
end
