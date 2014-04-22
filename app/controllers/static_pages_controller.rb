class StaticPagesController < ApplicationController
  layout "frontend"
  skip_before_action :authenticate_user!

  def tos
  end
end
