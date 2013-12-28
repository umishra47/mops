class Instance < ActiveRecord::Base
  belongs_to :user

  after_create :launch_ec2_instance

  private
  
  def launch_ec2_instance
    begin
      ec2 = AWS::EC2.new(access_key_id: AppConfig.access_key, secret_access_key: AppConfig.secret_token)
      response = ec2.instances.create(image_id: ami, instance_type: instance_type)
      cost = InstanceType.find_by_name(instance_type)[:cost]
      update_attributes({ec2_instance_id: response.id, launch_time: DateTime.now, cost: cost})
    rescue
      false
    end
  end
end
