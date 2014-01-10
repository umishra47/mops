class UserMailer < ActionMailer::Base
  default :from => "harjindersidhu12@gmail.com"
  
  def notification_email(user, instance)
    @user = user
    @instance = instance
    mail(to: @user.email, subject: '[MOPS] Instance Launch Alert')
  end
  
  def transaction_email(user, instance)
    @user = user
    @instance = instance
    mail(to: @user.email, subject: '[MOPS] Instance Launched Successfully')
  end
  
  def delete_instance(user, instance)
    @user = user
    @instance = instance
    mail(to: @user.email, subject: '[MOPS] Instance Termination Alert')
  end
  
  def subscription_notify_date(user, instance)
    @user = user
    @instance = instance
    mail(to: @user.email, subject: '[MOPS] Subscription renewable Alert')
  end
  
end