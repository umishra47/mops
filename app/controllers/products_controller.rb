class ProductsController < ApplicationController
  
  respond_to :html
  skip_before_action :authenticate_user!, only: [:transaction_details]
  before_action :set_digital_ocean
  
  def index
    respond_with @products = current_user.products.where(web_name: AppConfig.cloud[:name]).order('launch_time DESC')
  end

  def show
    if params[:cm]
      params_id = params[:cm]
      flash[:notice] = "Your Transaction is Completed. Thank You for Joining. You will be notified with the details after successful launch of your instance. "
    else
      params_id = params[:id]
    end
    @product = current_user.products.find(params_id)
    @subscriptions = @product.subscriptions if @product
    respond_with @product, @subscriptions
  end

  def new
    respond_with @product = current_user.products.new
  end

  def create
    Product.transaction do
      @product = current_user.products.create(product_params)
      type = AppConfig.cloud[:name]
      if type == "AWS"
        cost = ProductType.find_by_name(params[:product][:product_type]).cost_per_month
      elsif type == "DigitalOcean"
        cost = SizeType.find_by_size_id(params[:product][:size_type]).cost_per_month
      end
      @product.update_attributes(web_name: type, cost: cost, status: 'pending')
      paypal_url = @product.paypal_url
      if paypal_url
        redirect_to paypal_url
      else
        redirect_to :back
      end
    end
  end

  def destroy
    product = Product.find(params[:id])
    if product.profileId && product.product_id

      if product.web_name == "AWS"
        response = product.send(:destroy_instance)
        if response[:instances_set].first[:current_state][:name] == "shutting-down"
          ppr = PayPal::Recurring.new(:profile_id => product.profileId)
          ppr.cancel
          product.update_attributes(status: 'terminated')
          subscription = Subscription.find_by_product_id(params[:id])
          subscription.update_attributes(status: "expired")
        end
      elsif product.web_name == "DigitalOcean"
        response = product.send(:destroy_droplet)
        if response.status == "OK"
          ppr = PayPal::Recurring.new(:profile_id => product.profileId)
          ppr.cancel
          product.update_attributes(status: 'terminated')
          subscription = Subscription.where(product_id: product.id, status: "active")
          subscription.first.update_attributes(status: "expired") unless subscription.empty?
        end
      end

    end
    redirect_to :back
  end

  def transaction_details
    product = Product.find(params[:custom])
    Product.transaction do 
      if params[:txn_type] == "subscr_signup"
        UserMailer.notification_email(product.user, product).deliver
        product.update_attributes(profileId: params[:subscr_id])
      elsif params[:txn_type] == "subscr_payment" && params[:payment_status] == 'Completed'
        subscript = product.user.subscriptions.where(sub_tran: params[:txn_id])
        unless !subscript.empty?
          unless product.product_id
            if product.web_name == "AWS"
              product_type = product[:product_type]
              size_type = nil
              product.send(:launch_ec2_instance)
            elsif product.web_name == "DigitalOcean"
              size_type = product[:size_type]
              product_type = nil
              product.send(:launch_droplet)
            end
            end_date = product.launch_time + 30.days
            notify_date = end_date - 7.days

            #create subscription
            product.user.subscriptions.create(
             web_type: product.web_name, image_id: product.image_id,
             product_type: product_type, instance_id: product.product_id, sub_tran: params[:txn_id],
             size_type: size_type, user_id: product.user.id, product_id: product.id,
             start_date: product.launch_time, end_date: end_date, notify_date: notify_date, status: 'active'
            )
            product.update_attributes(status: 'launched')
            UserMailer.transaction_email(product.user, product).deliver
          else
            end_date = Date.today + 30.days
            notify_date = end_date - 7.days

            #Expire old subscription 
            prev_sub = Subscription.where(product_id: product.id, status: "active")
            prev_sub.first.update_attributes(status: 'expired') unless prev_sub.empty?

            #create new subscription
            product.user.subscriptions.create(
              web_type: product.web_name, image_id: product.image_id, product_type: product_type,
              instance_id: product.product_id, sub_tran: params[:txn_id], size_type: size_type,
              user_id: product.user.id, product_id: product.id, start_date: product.launch_time,
              end_date: end_date, notify_date: notify_date, status: 'active'
            )
            product.update_attributes(status: 'launched')
            UserMailer.new_payment_email(product.user, product).deliver
          end
        end
      elsif params[:txn_type] == "subscr_cancel"
        UserMailer.delete_instance(product.user, product).deliver
      end
    end
    redirect_to servers_path
  end
  
  def set_digital_ocean
    if AppConfig.cloud[:name] == "DigitalOcean"
      Digitalocean.client_id  = AppConfig.cloud[:creds][:access_key]
      Digitalocean.api_key    = AppConfig.cloud[:creds][:secret_token]
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :product_type, :size_type, :image_id, :region_id)
  end

end
