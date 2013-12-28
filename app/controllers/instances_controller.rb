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
    respond_with @instance = current_user.instances.create(instance_params)
  end
  
  private
  def instance_params
    params.require(:instance).permit(:name, :instance_type, :ami)
  end
end
