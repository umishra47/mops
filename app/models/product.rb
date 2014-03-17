include ActionView::Helpers::NumberHelper

class Product < ActiveRecord::Base
  include AwsAction

  belongs_to :user

  has_many :subscriptions
  default_scope { order('status') }

  before_create :add_ssh_keys

  def paypal_url
    if web_name == "AWS"
      val = product_type
    elsif web_name == "DigitalOcean"
      val = SizeType.find_by_size_id(size_type).name
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

end
