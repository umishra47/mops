Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "opocukjvQIxgY3exHSGUCQ", "iivLsD3q5BsaM0GKM54cAyoi4tywEYn3dodKXDoN0"
  provider :google_oauth2, "664022931868-48jsgcas73niirgr2bsg6pe0rllk63mu.apps.googleusercontent.com", "h4sYLgpzAI76-f0NQuzb1rwv"

  OmniAuth.config.on_failure = Proc.new { |env|
    OmniAuth::FailureEndpoint.new(env).redirect_to_failure
  }
end