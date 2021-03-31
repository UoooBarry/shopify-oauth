require 'securerandom'

class ShopifyController < ApplicationController
  def index
    # get params here
    @shop = params[:shop]
    @code = params[:code]
    throw 'State not correct' unless session[@shop.to_sym] = params[:state]

    flash[:success] = 'Oauth success, login to our website to continue'
  end

  def authorize
    api_key = 'a50bade1fb2ba1906a43e390d55e4b85' 
    shop = params[:shop]
    params[:timestamp]
    params[:hmac]

    uuid = SecureRandom.uuid
    session[shop.to_sym] = uuid # Can replace with database record
    @url = "https://#{shop}/admin/oauth/authorize?client_id=#{api_key}&scope=read_customers&redirect_uri=http://localhost:3000/shopify/oauth&state=#{uuid}&grant_options[]="
          
    redirect_to @url
  end

  def confirm
    shop = params[:session][:shop]
    @user = User.find_by(username: params[:session][:username])
        if @user && @user.authenticated?(params[:session][:password])
          flash[:success] = 'Welcome to the underground world!'
          log_in(@user)
          
          redirect_to home_index_path
        else
          flash[:danger] = 'Invalid username & password combination'
          redirect_to new_session_path
    end
  end
end
