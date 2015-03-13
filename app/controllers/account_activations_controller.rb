class AccountActivationsController < ApplicationController
  
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.act_authenticated?(:activation, params[:id])
      user.update_attribute(:activated,    true)
      user.update_attribute(:activated_at, Time.zone.now)
      flash[:success] = "Account activated!"
      redirect_to signin_url
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
