class Users::RegistrationsController < Devise::RegistrationsController
  layout 'login'

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end
  
  def create
    super
    session[:omniauth] = nil unless @user.new_record?
  end
  
  def auth
  end
  
  def add_mail
    if params[:user]
      if User.find_by_email(params[:user][:email])
        user = User.find_by_email(params[:user][:email])
      else
        user = User.new
        user.skip_confirmation!
        user.email = params[:user][:email]
        user.save(:validate => false)
      end
      auth = Authentication.find_by_uid(session[:auth])
      user.authentications << auth
      flash[:notice] = "Signed in successfully."
      sign_in user 
      redirect_to root_url
    end
  end

  private :sign_up_params
  private :account_update_params

  private

  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end
  
  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end
end