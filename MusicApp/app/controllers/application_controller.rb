class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_login, except: [:index]
  # before_action :require_admin, except: [:index, :show]

  helper_method :current_user, :logged_in?

  def current_user
    User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !current_user.nil?
  end

  def login!(user)
    session[:session_token] = user.session_token
  end

  def logout!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def activated?
    current_user.activate
  end

  def require_login
    redirect_to root_url unless logged_in? && activated?
  end

  # def admin?
  #   current_user.admin if current_user
  # end
  #
  # def require_admin
  #   redirect_to root_url unless admin?
  # end
end
