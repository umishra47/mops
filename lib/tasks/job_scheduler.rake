namespace :job_scheduler do

  task :send_renew_alert => :environment do
    notifications = Subscription.where(notify_date: Date.today, status: "active")
    notifications.each do |notify|
      user = User.find(notify.user_id)
      instance = Instance.find(notify.instance_id)
      UserMailer.subscription_notify_date(user, instance).deliver
    end
  end

  desc "daily backup of db dump"
  task making_dump: :environment do
	datestamp = Time.now.strftime("%Y-%m-%d_%H:%M:%S")
  	root = Rails.root.to_s
  	user = ENV['DB_USERNAME']
  	pass = ENV['DB_PASSWORD']
  	host = ENV['HOST_NAME']
  	system "pg_dump --host #{host} --username #{user} --verbose --clean --no-owner --no-acl  mops_new_production > #{root}/db/dump/database_backup_#{datestamp}.sql"
  end

  desc "delete dump file once 30 days old"
  task deleting_dump: :environment do
  	root = Rails.root.to_s
  	system "find #{root}/db/dump/*.sql -mtime +30 -type f -delete"
  end

end