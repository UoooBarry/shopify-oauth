class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'A gopher has entered our underground world!'
      redirect_to new_session_path
    else
      flash[:danger] = @user.errors.full_messages.to_sentence
      redirect_to new_user_path
    end
  end

  private
  def user_params
    params.require(:user).
      permit(:username,:gender,:password,:age,:bio)
  end
end
