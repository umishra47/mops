class CustomFailure < Devise::FailureApp
  def redirect_url
    if warden_options[:scope] == :user
      attempted_path == "/users/sign_in" ? "/users/sign_in" : regist_path
      else
      root_path
    end
  end
  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end