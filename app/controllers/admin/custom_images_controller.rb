class Admin::CustomImagesController < ApplicationController

  def new
    unless current_user.is_admin
      flash[:error] = "You are not authorised to visit this page."
      redirect_to "/"
    end

    @image = CustomImage.new
  end

  def create
    unless current_user.is_admin
      flash[:error] = "You are not authorised to visit this page."
      redirect_to "/"
    end

    @image = CustomImage.create(image_params)
    @image.save!
  end

private
  def image_params
    params.require(:custom_image).permit(:name, :hosting, :remote_image_id,
          :price, :ram, :region, :description)
  end
end
