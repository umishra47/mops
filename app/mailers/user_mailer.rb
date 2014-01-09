class UserMailer < ActionMailer::Base
  default :from => "harjindersidhu12@gmail.com"
  
  def transaction_email(user)
    @user = user
    @url  = 'http://localhost:3000'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
  
  def delete_instance(user, instance)
    @user = user
    @instance = instance
    mail(to: @user.email, subject: 'Instance Terminated')
  end
  
   def notification_email(user, instance)
    @user = user
    @instance = instance
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end