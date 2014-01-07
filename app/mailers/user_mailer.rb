class UserMailer < ActionMailer::Base
  default :from => "harjindersidhu12@gmail.com"
  
  def transaction_email(user)
    @user = user
    @url  = 'http://localhost:3000'
    for i in 0..5
      mail(to: "hsingh@enbake.com", subject: 'Welcome to My Awesome Site')
    end
  end
end