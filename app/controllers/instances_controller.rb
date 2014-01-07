class InstancesController < ApplicationController

  respond_to :html
  
  def index
    respond_with @instances = current_user.instances.order('launch_time DESC')
  end

  def show
    @instance = Instance.find(params[:id])
    paypal_url = @instance.paypal_url
    debugger
    if paypal_url
      redirect_to paypal_url
    else
      redirect_to :back
    end
  end

  def new
    respond_with @instance = current_user.instances.new
  end

  def create
    @instance = current_user.instances.create(instance_params)
    cost = InstanceType.find_by_name(params[:instance][:instance_type]).cost
    @instance.update_attributes(cost: cost)
    respond_with @instance
  end
  
  def transaction_details
    if params[:st] == "Completed"
      UserMailer.transaction_email(current_user).deliver
      instance = Instance.find(params[:cm])
      instance.launch_ec2_instance
      end_date = instance.launch_time + 30.days
      notify_date = end_date - 7.days
      Subscription.create(ami: instance.ami, type: instance.instance_type, user_id: current_user.id, 
        instance_id: instance.ec2_instance_id, start_date: instance.launch_time, end_date: end_date, 
        notify_date: notify_date)
      flash[:notice] = "Your Transaction is #{params[:st]} for amount of $#{params[:amt]}. Thank You for shopping."
    end
    redirect_to root_url
  end
  
  private
  def instance_params
    params.require(:instance).permit(:name, :instance_type, :ami)
  end
end
