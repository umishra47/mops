class SessionsController < ApplicationController
  def new
  end

  def create
    auth = request.env["omniauth.auth"]
    @unit = Unit.find_by_provider_and_uid(auth["provider"], auth["uid"]) || Unit.create_with_omniauth(auth)
    session[:unit_id] = @unit.id
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session[:unit_id] = nil
    redirect_to root_url, notice: "Signed out!"
  end

  def failure
    redirect_to root_url, alert: "Authentication failed, please try again."
  end
end
