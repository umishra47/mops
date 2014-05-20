class ImagesController < ApplicationController

  def new
    unless current_user.is_admin
      flash[:error] = "You are not authorised to visit this page."
      redirect_to "/"
    end
  end

end
