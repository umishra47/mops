include ActionView::Helpers::NumberHelper

class Product < ActiveRecord::Base
  include AwsAction

  belongs_to :user

  has_many :subscriptions
  default_scope { order('status') }

  before_create :add_ssh_keys

  def paypal_url
    if custom_image_id
      val = "Custom Image #{custom_image_id}"
    else
      if web_name == "AWS"
        val = product_type
      elsif web_name == "DigitalOcean"
        val = SizeType.find_by_size_id(size_type).name
      end
    end
    values = {
      :business => AppConfig.business_email,
      :cmd => '_xclick-subscriptions',
      :upload => 1,
      :item_name => name + ' (' + val + ')',
      :a3 => number_with_precision(cost, precision: 0),
      :p3 => '1',
      :t3 => 'M',
      :no_note => '1',
      :src => '1',
      :sra => '1',
      :cancel_return => AppConfig.cancel_url,
      :custom => id
    }
    AppConfig.paypal_url + "cgi-bin/webscr?" + values.to_query
  end
  
  def add_ssh_keys
    key = SSHKey.generate
    self[:private_ssh_key] = key.private_key
    self[:public_ssh_key] = key.ssh_public_key
  end

  # set_attributes
  # To be called only when cost and other calculable attributes are to be set.
  def set_attributes
    self.web_name = AppConfig.cloud[:name]
    if self.custom_image_id
      ci = CustomImage.find_by_id!(custom_image_id)
      self.cost = ci.price
      self.region = ci.region
      self.image_id = ci.remote_image_id

      #Map product_type or size_type since that is being used across the app.
      if ci.hosting == "AWS"
        pt = ProductType.find_by_memory!(ci.ram)
        self.product_type = pt.name
        self.size_type = nil
      elsif ci.hosting == "DigitalOcean"
        st = SizeType.find_by_memory!(ci.ram)
        self.size_type = st.size_id
        self.product_type = nil
      end
    else
      if type == "AWS"
        self.cost = ProductType.find_by_name(params[:product][:product_type]).cost_per_month
      elsif type == "DigitalOcean"
        self.cost = SizeType.find_by_size_id(params[:product][:size_type]).cost_per_month
      end
    end

    self.status = 'pending'
  end
end
