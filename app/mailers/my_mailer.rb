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
end