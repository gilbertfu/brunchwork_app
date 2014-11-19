class EmailsController < ApplicationController
  #need to figure out how to unsubscribe easily for admins and for users
  #before_action :admin_index_page, only: :destroy
  http_basic_authenticate_with :name => "admin", :password => ENV['ADMIN_PASSWORD'], only: [:index, :send_email]
  
  
  def create
    @email = Email.new(email_params)
    if @email.save
      MyMailer.welcome_email(@email).deliver
      #flash[:success] = "Thank You For Subscribing!"
      redirect_to root_url
    else
       render "static_pages/home"
    end
  end
  
  def index
    @emails = Email.all
  end
  
  def show
    @email = Email.find_by(:unsubscribe_hash=>params[:unsubscribe_hash])
    if @email == nil
      redirect_to root_url
    end
  end
  
  def destroy
    #how to get email parameter to destroy
    #if params[:delete] == true
      @email = Email.find_by(:unsubscribe_hash=>params[:unsubscribe_hash])
      if @email != nil
        @email.destroy
        #flash[:success] = "Successfully Unsubscribed"
        redirect_to root_url
      end
  end
  
  def send_email
    @content = params[:email][:email_content]
    @emails = Email.all
    @subject = params[:email][:subject_line]
    @emails.each do |email|
      MyMailer.newsletter_email(email, @content, @subject).deliver
    end
    #flash[:success] = "Messages Sent!"
    redirect_to emails_path
  end
  
  private
  
    def email_params
      params.require(:email).permit(:email)
    end
end