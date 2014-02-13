class WelcomeController < ApplicationController
  layout "frontend"
  skip_before_action :authenticate_user!
  def index
  end
  def landing
  end
  def pricing
  end
end
