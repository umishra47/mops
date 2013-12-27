class ImagesController < ApplicationController

  def sync
    ec2 = AWS::EC2.new(access_key_id: AppConfig.access_key, secret_access_key: AppConfig.secret_token)
    response = ec2.client.describe_images({owners: ["self"]})
    response[:images_set].each do |obj|
      @image = Image.find_or_create_by_image_id(obj[:image_id])
      @image.update_attributes(name: obj[:name], is_public: obj[:is_public], image_state: obj[:image_state])
    end
  end

end
