class SessionsController < ApplicationController
  def new
    if signed_in?
      redirect_to events_path
    end
  end

  def create
    if signed_in?
      redirect_to current_user
    end
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        sign_in user
        #redirect_back_or user
        redirect_to user
      else
        flash[:danger] = 'Account not activated. Please check email for activation link'
        flash.keep(:danger)
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end
