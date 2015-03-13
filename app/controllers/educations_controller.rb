class EducationsController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user,   only: :destroy
  respond_to :html, :js

  def create
    @education = current_user.educations.build(education_params)
    if @education.save
      @user = current_user
    else
      flash[:danger] = "Education must have a school and degree field"
      @user = current_user
      flash.keep(:danger)
      render js: "window.location = '#{user_path(current_user)}'"
    end
  end

  def destroy
    current_user.educations.find_by(:id => params[:id]).destroy
    @user = current_user
    #@education.destroy
   # redirect_to current_user
  end

  private

    def education_params
      params.require(:education).permit(:school, :major, :degree, :grad_year)
    end
    
    def correct_user
      @education = current_user.educations.find_by(id: params[:id])
      render js: "window.location = '#{root_url}'" if @education.nil?
    end
    
end