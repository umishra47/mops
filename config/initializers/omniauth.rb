Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "UCy4NZ9aItctPX635i7tA", "Z5JEHwGC3MbCGPSSXo5XBUVWvNY3J02lJIop1FChc"
  provider :google_oauth2, "168268692145-ftej6o88omro37vst1lk3khvr4tk373i.apps.googleusercontent.com", "Q-OWLYtj4AyZXVeXuLTTSxm0"
  provider :facebook, "562013967202594", "4616544513db14594052669bfbe9a13f"
end