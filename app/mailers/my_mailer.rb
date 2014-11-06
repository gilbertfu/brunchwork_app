class MyMailer < ActionMailer::Base
  default :from => 'brunchwork.test@gmail.com'
  
  def welcome_email(email)
    @email = email
    
    mail(to: email.email,
         from: 'brunchwork.test@gmail.com',
         subject: 'Welcome!')
  end
  
  def newsletter_email(email, content, subject_line)
    @email = email
    @content = content
    mail(to: email.email,
         from: 'brunchwork.test@gmail.com',
         subject: subject_line)
  end
end