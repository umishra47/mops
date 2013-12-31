Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "UCy4NZ9aItctPX635i7tA", "Z5JEHwGC3MbCGPSSXo5XBUVWvNY3J02lJIop1FChc"
  provider :google_oauth2, "168268692145-ftej6o88omro37vst1lk3khvr4tk373i.apps.googleusercontent.com", "Q-OWLYtj4AyZXVeXuLTTSxm0"

  OmniAuth.config.on_failure = Proc.new { |env|
    OmniAuth::FailureEndpoint.new(env).redirect_to_failure
  }
end