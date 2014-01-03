namespace :job_scheduler do

  task :send_renew_alert => :environment do
    notificatios = Subscription.where(notify_date: Date.today)
    notifications.each do |notify|
      user = User.find(notify.user_id)
      UserMailer.welcome_email(user).deliver
    end
  end

  task :charge_cost => :environment do
    subscriptions = Subscription.where(start_date: Date.today)
    subscriptions.each do |subscribe|
      
    end
  end

end