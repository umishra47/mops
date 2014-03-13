Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "opocukjvQIxgY3exHSGUCQ", "iivLsD3q5BsaM0GKM54cAyoi4tywEYn3dodKXDoN0"
  provider :google_oauth2, "664022931868-6n8b2cm15ub1ic8a63m9bhdr6krcsh5e.apps.googleusercontent.com", "b9f52a44ed549452e64a74b0fbfb520e5a62ff16"

  OmniAuth.config.on_failure = Proc.new { |env|
    OmniAuth::FailureEndpoint.new(env).redirect_to_failure
  }
end