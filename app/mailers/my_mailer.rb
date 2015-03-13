class MyMailer < ActionMailer::Base
  default :from => 'Brunchwork'
  
  def welcome_email(email)
    @email = email
    
    mail(to: email.email,
         from: 'Brunchwork',
         subject: 'Welcome!')
  end
  
  def newsletter_email(email, content, subject_line)
    @email = email
    @content = content
    mail(to: email.email,
         from: 'Brunchwork',
         subject: subject_line)
  end
  
  def account_activation(user)
    @user = user
    mail(to: @user.email,
         from: 'Brunchwork',
         subject: 'Activate Account')
  end
  
  def password_reset(user)
    @user = user
    mail(to: @user.email,
         from: 'Brunchwork',
         subject: 'Reset Password')
  end
  
end