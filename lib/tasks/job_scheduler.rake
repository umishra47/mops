namespace :job_scheduler do

  task :send_renew_alert => :environment do
    notifications = Subscription.where(notify_date: Date.today, status: "active")
    notifications.each do |notify|
      user = User.find(notify.user_id)
      instance = Instance.find(notify.instance_id)
      UserMailer.subscription_notify_date(user, instance).deliver
    end
  end
  
  task :update_end_date => :environment do
    subscription_end_dates = Subscription.where(end_date: Date.today, status: "active")
    end_date = Date.today + 1.month
    notify_date = end_date - 7.days
    subscription_end_dates.each do |subscription|
      subscription.update_attributes(end_date: end_date,notify_date: notify_date)
    end
  end
end