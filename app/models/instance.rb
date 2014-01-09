class Instance < ActiveRecord::Base
  belongs_to :user
  
  has_many :subscriptions
  default_scope { order('status') } 
  
  def paypal_url
    values = {
      :business => "dummy09807@gmail.com",
      :cmd => '_xclick-subscriptions',
      :upload => 1,
      :item_name => name + ' (' + instance_type + ')',
      :a3 => number_with_precision(cost, precision: 0),
      :p3 => '1',
      :t3 => 'M',
      :no_note => '1',
      :src => '1',
      :sra => '1',
      :cancel_return => AppConfig.cancel_url,
      :custom => id
    }
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end
  
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
