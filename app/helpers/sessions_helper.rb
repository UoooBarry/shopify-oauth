module SessionsHelper
  def log_in(user)
    session[:user] = user
  end
  
  def current_user
    session[:user]
  end

  def logged_in?
    current_user.present?
  end

  def log_out
    session[:user] = nil
  end
end
