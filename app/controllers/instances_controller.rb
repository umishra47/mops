class InstancesController < ApplicationController

  respond_to :html
  skip_before_action :authenticate_user!, only: [:transaction_details]
  def index
    respond_with @instances = current_user.instances.order('launch_time DESC')
  end
  
  def show
    if params[:cm]
      params_id = params[:cm]
      flash[:notice] = "Your Transaction is Completed. Thank You for Joining."
    else
      params_id = params[:id]
    end
    respond_with @instance = current_user.instances.find(params_id)
  end

  def new
    respond_with @instance = current_user.instances.new
  end

  def create
    Instance.transaction do 
      @instance = current_user.instances.create(instance_params)
      cost = InstanceType.find_by_name(params[:instance][:instance_type]).cost
      @instance.update_attributes(cost: cost, status: 'pending')
      
      paypal_url = @instance.paypal_url
      if paypal_url
        redirect_to paypal_url
      else
        redirect_to :back
      end
    end
  end
  
  def destroy
    instance = Instance.find(params[:id])
    if instance.profileId && instance.ec2_instance_id
      ec2 = AWS::EC2.new(access_key_id: AppConfig.access_key, secret_access_key: AppConfig.secret_token)
      response = ec2.client.terminate_instances({instance_ids: [instance.ec2_instance_id]})
      if response[:instances_set].first[:current_state][:name] == "shutting-down"
        ppr = PayPal::Recurring.new(:profile_id => instance.profileId)
        ppr.cancel
        instance.update_attributes(status: 'terminated')
        subscription = Subscription.find_by_instance_id(params[:id])
        subscription.update_attributes(status: "expired")
      end
    end  
    redirect_to :back
  end
  
  def transaction_details
    instance =  Instance.find(params[:custom])
    Instance.transaction do 
      if params[:txn_type] == "subscr_signup"
        UserMailer.notification_email(instance.user, instance).deliver
        instance.update_attributes(profileId: params[:subscr_id])
      elsif params[:txn_type] == "subscr_payment" && params[:payment_status] == 'Completed'
        unless instance.ec2_instance_id
          instance.send(:launch_ec2_instance)
          end_date = instance.launch_time + 30.days
          notify_date = end_date - 7.days
          Subscription.create(ami: instance.ami, instance_type: instance[:instance_type], user_id: instance.user.id, 
            instance_id: instance.id, start_date: instance.launch_time, end_date: end_date, 
            notify_date: notify_date, status: 'active')
          instance.update_attributes(status: 'launched')
          UserMailer.transaction_email(instance.user, instance).deliver
        end
      elsif params[:txn_type] == "subscr_cancel"
        UserMailer.delete_instance(instance.user, instance).deliver
      end
    end
    redirect_to login_path
  end
  
  private
  def instance_params
    params.require(:instance).permit(:name, :instance_type, :ami)
  end
end
