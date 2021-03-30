class ShopifyController < ApplicationController
  def oauth
    # get params here
    
    @shop = params[:shop]
    params[:timestamp]
    params[:hmac]

  end

  def confirm
    api_key = 'a50bade1fb2ba1906a43e390d55e4b85' 
    shop = params[:session][:shop]
    @user = User.find_by(username: params[:session][:username])
        if @user && @user.authenticated?(params[:session][:password])
          flash[:success] = 'Welcome to the underground world!'
          log_in(@user)
          
          @url = "https://#{shop}/admin/oauth/authorize?client_id=#{api_key}&scope=read_customers&redirect_uri=http://localhost:3000/home&state=#{current_user.id}&grant_options[]="
          
          redirect_to @url  
        else
          flash[:danger] = 'Invalid username & password combination'
          redirect_to new_session_path
    end
  end
end
