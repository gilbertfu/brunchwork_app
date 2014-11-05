class EmailsController < ApplicationController
  #need to figure out how to unsubscribe easily for admins and for users
  #before_action :admin_index_page, only: :destroy
  http_basic_authenticate_with :name => "admin", :password => "evanandgilbert", only: :index
  
  
  def create
    @email = Email.new(email_params)
    if @email.save
      MyMailer.welcome_email(@email).deliver
      flash[:success] = "Thank You For Subscribing!"
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
  end
  
  def destroy
    #how to get email parameter to destroy
    #if params[:delete] == true
      Email.find_by(:unsubscribe_hash=>params[:unsubscribe_hash]).destroy
      flash[:success] = "Successfully Unsubscribed"
      redirect_to root_url
  end
  
  private
  
    def email_params
      params.require(:email).permit(:email)
    end
end