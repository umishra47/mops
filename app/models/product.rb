include ActionView::Helpers::NumberHelper

class Product < ActiveRecord::Base
  include AwsAction

  belongs_to :user

  has_many :subscriptions
  default_scope { order('status') } 

  def paypal_url
    if web_name == "AWS"
      val = product_type
    elsif web_name == "DigitalOcean"
      val = size_type.to_s
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
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end

end
