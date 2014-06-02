module AwsAction

  private

  def destroy_instance
    ec2 = AWS::EC2.new(access_key_id: AppConfig.cloud[:creds][:access_key], secret_access_key: AppConfig.cloud[:creds][:secret_token])
    response = ec2.client.terminate_instances({instance_ids: [product_id]})
  end

  def launch_ec2_instance
    begin
      ec2 = AWS::EC2.new(access_key_id: AppConfig.cloud[:creds][:access_key], secret_access_key: AppConfig.cloud[:creds][:secret_token])
      response = ec2.instances.create(image_id: image_id, instance_type: product_type, key_name: "mops_master_key")
      ec2.client.create_tags(resources: [response.id], tags: [{ key: 'Name', value: "Mops_Instance_#{id}" }, { key: 'Internal_name', value: name }])
      sleep 60
      description = ec2.client.describe_instances({instance_ids: [response.id]})
      instances_set = description.reservation_set.map(&:instances_set).flatten!
      dns_name = instances_set.first.dns_name
      cost = ProductType.find_by_name(product_type)[:cost_per_month].to_s
      update_attributes({product_id: response.id, launch_time: DateTime.now, cost: cost, dns_name: dns_name})
    rescue
      false
    end
  end

  def launch_droplet
    begin
      ssh_key = Digitalocean::SshKey.create(name: "#{name}_#{id}", ssh_pub_key: public_ssh_key)
      region_slug = region.nil? ? Hash[AppConfig.region_ids].key(image_id.to_i) : region
      response = Digitalocean::Droplet.create({name: name, size_id: size_type, image_id: image_id.to_i, 
                                               region_slug: region_slug, 
                                               ssh_key_ids: ssh_key.ssh_key.id.to_s})
      sleep 15
      response1 = Digitalocean::Droplet.retrieve(response.droplet.id)
      update_attributes({product_id: response.droplet.id, launch_time: DateTime.now, cost: cost, dns_name: response1.droplet.ip_address})
    rescue
      false
    end
  end
  
  def destroy_droplet
    response = Digitalocean::Droplet.destroy(product_id.to_i)
  end

end