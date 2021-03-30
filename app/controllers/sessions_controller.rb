class SessionsController < ApplicationController
    def new
      
    end

    def create
        @user = User.find_by(username: params[:session][:username])
        if @user && @user.authenticated?(params[:session][:password])
          flash[:success] = 'Welcome to the underground world!'
          log_in(params[:session][:username])
          redirect_to home_index_path  
        else
          flash[:danger] = 'Invalid username & password combination'
          redirect_to new_session_path
        end
    end

    def destroy
      log_out
      flash[:warning] = 'Logout succssfully'
      redirect_to home_index_path
    end
end
