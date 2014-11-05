class MyMailer < ActionMailer::Base
  default :from => 'brunchwork.test@gmail.com'
  
  def welcome_email(email)
    @email = email
    
    mail(to: email.email,
         from: 'brunchwork.test@gmail.com',
         subject: 'Welcome!')
  end
end