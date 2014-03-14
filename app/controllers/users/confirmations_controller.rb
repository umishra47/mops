class Users::ConfirmationsController < Devise::ConfirmationsController
  layout 'login'
  def new
    super
  end
  
  def create
    super
  end
  
  def show
    resource = User.confirm_by_token(params[:confirmation_token])

    if resource.errors.empty?
      flash[:notice] = "Your account was successfully confirmed."
      sign_in(resource) # <= THIS LINE ADDED
      redirect_to (session[:user_return_to] ? session[:user_return_to] : root_url) and return
    else
      flash[:notice] = "If your email address exists in our database, you will receive an email with instructions about how to confirm your account in a few minutes."
      redirect_to root_url and return
    end
  end
end