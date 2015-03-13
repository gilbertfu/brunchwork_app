class EmploymentsController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user,   only: :destroy
  respond_to :html, :js

  def create
    @employment = current_user.employments.build(employment_params)
    if @employment.save
      @user = current_user
    else
      flash[:danger] = "Employment must have a company and position field"
      @user = current_user
      flash.keep(:danger)
      render js: "window.location = '#{user_path(current_user)}'"
    end
  end

  def destroy
    current_user.employments.find_by(:id => params[:id]).destroy
    @user = current_user
  end

  private

    def employment_params
      params.require(:employment).permit(:company, :title, :start_date, :end_date)
    end
    
    def correct_user
      @employment = current_user.employments.find_by(id: params[:id])
      render js: "window.location = '#{root_url}'" if @employment.nil?
    end
end