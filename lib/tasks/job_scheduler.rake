namespace :job_scheduler do

  task :send_renew_alert => :environment do
    notifications = Subscription.where(notify_date: Date.today)
    notifications.each do |notify|
      user = User.find(notify.user_id)
      instance = Instance.find(notify.instance_id)
      UserMailer.subscription_notify_date(user, instance).deliver
    end
  end

end