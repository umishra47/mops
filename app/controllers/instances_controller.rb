class InstancesController < ApplicationController

  respond_to :html
  
  def index
    respond_with @instances = current_user.instances.order('launch_time DESC')
  end
  
  def show
    respond_with @instance = current_user.instances.find(params[:id])
  end

  def new
    respond_with @instance = current_user.instances.new
  end

  def create
    @instance = current_user.instances.create(instance_params)
    cost = InstanceType.find_by_name(params[:instance][:instance_type]).cost
    @instance.update_attributes(cost: cost)
    
    paypal_url = @instance.paypal_url
    if paypal_url
      session[:instance_id] = @instance.id
      redirect_to paypal_url
    else
      redirect_to :back
    end
  end
  
  def destroy
    instance = Instance.find(params[:id])
    if instance.profileId
      ppr = PayPal::Recurring.new(:profile_id => instance.profileId)
      ppr.cancel
      UserMailer.delete_instance(current_user,instance).deliver
    end  
    instance.destroy
    redirect_to :back
  end
  
  def transaction_details
    if params[:token] && params[:PayerID]
      instance =  Instance.find(session[:instance_id])
      session.delete('instance_id')
      ppr = PayPal::Recurring.new({
        :amount      => "1.50",
        :currency    => "USD",
        :description => instance.name + ' (' + instance.instance_type + ')',
        :ipn_url     => AppConfig.return_url,
        :frequency   => 1,
        :token       => params[:token],
        :period      => :monthly,
        :reference   => "1234",
        :payer_id    => params[:PayerID],
        :start_at    => Time.now,
        :failed      => 1,
        :outstanding => :next_billing
      })
      
      response = ppr.create_recurring_profile
      if response.profile_id
        instance.update_attributes(token: params[:token], profileId: response.profile_id)
        UserMailer.transaction_email(current_user).deliver
        instance.launch_ec2_instance
        end_date = instance.launch_time + 30.days
        notify_date = end_date - 7.days
        Subscription.create(ami: instance.ami, type: instance.instance_type, user_id: current_user.id, 
          instance_id: instance.ec2_instance_id, start_date: instance.launch_time, end_date: end_date, 
          notify_date: notify_date)
        flash[:notice] = "Your Transaction is #{instance.name} for amount of $#{instance.cost}. Thank You for shopping."
      end
    end
    redirect_to root_url
  end
  
  private
  def instance_params
    params.require(:instance).permit(:name, :instance_type, :ami)
  end
end
