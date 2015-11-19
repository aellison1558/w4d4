class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_credentials(email, password)
    if @user
      login!(@user)
      redirect_to user_url(@user)
    else
      render :new
    end
  end

  def destroy
    logout
    redirect_to new_session_url
  end

  private
  def email
    params[:login][:email]
  end

  def password
    params[:login][:password]
  end
end
