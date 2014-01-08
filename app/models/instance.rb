class Instance < ActiveRecord::Base
  belongs_to :user
  
  has_many :subscriptions
  after_create :launch_ec2_instance
  
  def paypal_url
    ppr = PayPal::Recurring.new({
      :return_url   => AppConfig.return_url,
      :cancel_url   => AppConfig.cancel_url,
      :ipn_url      => AppConfig.return_url,
      :description  => name + ' (' + instance_type + ')',
      :amount       => "1.50",
      :currency     => "USD"
    
    })
    response = ppr.checkout
    response.valid? ? response.checkout_url : nil
    #"amount_1" => number_with_precision(cost, precision: 0),
  end
  
  private
  
  def launch_ec2_instance
    begin
      #      ec2 = AWS::EC2.new(access_key_id: AppConfig.access_key, secret_access_key: AppConfig.secret_token)
      #      response = ec2.instances.create(image_id: ami, instance_type: instance_type)
      #      cost = InstanceType.find_by_name(instance_type)[:cost]
      #      update_attributes({ec2_instance_id: response.id, launch_time: DateTime.now, cost: cost})
    rescue
      false
    end
  end
  
end
