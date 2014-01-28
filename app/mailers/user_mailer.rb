class UserMailer < ActionMailer::Base
  default :from => "harjindersidhu12@gmail.com"
  
  def notification_email(user, product)
    @user = user
    @product = product
    mail(to: @user.email, subject: '[MOPS] Instance Launch Alert')
  end
  
  def transaction_email(user, product)
    @user = user
    @product = product
    mail(to: @user.email, subject: '[MOPS] Instance Launched Successfully')
  end
  
  def delete_instance(user, product)
    @user = user
    @product = product
    mail(to: @user.email, subject: '[MOPS] Instance Termination Alert')
  end
  
  def subscription_notify_date(user, product)
    @user = user
    @product = product
    mail(to: @user.email, subject: '[MOPS] Subscription renewable Alert')
  end
  
  def new_payment_email(user, product)
    @user = user
    @product = product
    mail(to: @user.email, subject: '[MOPS] Subscription renewed Alert')
  end
  
end