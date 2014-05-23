class Admin::ImagesController < ApplicationController

  def new
    unless current_user.is_admin
      flash[:error] = "You are not authorised to visit this page."
      redirect_to "/"
    end

    @image = Image.new
  end

  def create
    unless current_user.is_admin
      flash[:error] = "You are not authorised to visit this page."
      redirect_to "/"
    end

    @image = Image.create(image_params)
    @image.save!
  end

private
  def image_params
    params.require(:image).permit(:name, :hosting, :remote_image_id, :price, :ram, :description)
  end
end
