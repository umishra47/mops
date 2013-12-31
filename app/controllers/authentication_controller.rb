class AuthenticationController < ApplicationController
  skip_before_filter :authenticate_user!
  def index
  end

  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      flash[:notice] = "Signed in successfully."
      sign_in authentication.user 
      redirect_to root_url
    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'], :token => omniauth['credentials']['token'])
      flash[:notice] = "Authentication successful."
      redirect_to root_url
    else
      if omniauth['provider'] == "twitter"
        authentication = Authentication.create(:provider => omniauth['provider'], :uid => omniauth['uid'], :token => omniauth['credentials']['token'])
        session[:auth] = authentication.uid
        redirect_to add_mail_path
      elsif User.find_by_email(omniauth['info']['email'])
        user = User.find_by_email(omniauth['info']['email'])
        user.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'], :token => omniauth['credentials']['token'])
        flash[:notice] = "Authentication successful."
        sign_in user
        redirect_to root_url
      else
        user = User.new
        user.skip_confirmation!
        user.apply_omniauth(omniauth)
        if user.save(:validate => false)
          flash[:notice] = "Signed in successfully."
          sign_in user 
          redirect_to root_url 
        else
          session[:omniauth] = omniauth.except('extra')
          redirect_to root_url 
        end
      end
    end
  end

  def destroy
  end
end
