class UsersController < ApplicationController
before_action :signed_in_user, only: [:index, :show, :edit, :update, :destroy, :admin, :private_resume, :remove_resume, :remove_prof_pic]
before_action :correct_user,   only: [:edit, :update, :private_resume, :remove_resume, :remove_prof_pic]
before_action :admin_user,     only: [:destroy, :admin]
respond_to :html, :js

  def show
    @user = User.find(params[:id])
    @comments = @user.comments.reorder("created_at DESC").paginate(page: params[:page], :per_page => 3)
    #@microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to brunchwork!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    #if old password is able to authenticate correctly
    if @user.authenticate(params[:user][:old_password])
      #if new password is not provided
      if params[:user][:password].blank?
        #update all attributes, and use the old password as password/confirmation
        if @user.update_attributes(:email => params[:user][:email], 
                                   :name => params[:user][:name],
                                   :school => params[:user][:school],
                                   :company => params[:user][:company],
                                   :work_position => params[:user][:work_position],
                                   :image => params[:user][:image],
                                   :resume => params[:user][:resume],
                                   :password => params[:user][:old_password],
                                   :password_confirmation => params[:user][:old_password],
                                   :goal => params[:user][:goal])
            if params[:user][:remove_image] == '1'
                @user.remove_image!
                @user.save
            end
            if params[:user][:remove_resume] == '1'
                @user.remove_resume!
                @user.save
            end
            flash[:success] = "Profile Updated"
            redirect_to @user
        else
            render 'edit'
        end
      else
        #update all attributes
        if @user.update_attributes(user_params)
          if params[:user][:remove_image] == '1'
                @user.remove_image!
                @user.save
          end
          if params[:user][:remove_resume] == '1'
                @user.remove_resume!
                @user.save
          end
          flash[:success] = "Profile updated"
          redirect_to @user
        else
          render 'edit'
        end
      end
    else
      flash.now[:warning] = "Must Provide Correct Password to Update Profile"
      render 'edit'
    end
  end
  
  def index
    @filtered = User.all
    @search = User.new(:email => "dummy@brunchwork.com", 
                       :name => "",
                       :school => "",
                       :company => "",
                       :work_position => "",
                       :password => "password",
                       :password_confirmation => "password")
    if !params[:user].nil? && !params[:user][:name].empty?
     @filtered = @filtered.where("name LIKE ?", "%#{params[:user][:name]}%")
    end
    if !params[:user].nil? && !params[:user][:school].empty?
     @filtered = @filtered.where("school LIKE ?", "%#{params[:user][:school]}%")
    end
    if !params[:user].nil? && !params[:user][:company].empty?
     @filtered = @filtered.where("company LIKE ?", "%#{params[:user][:company]}%")
    end
    if !params[:user].nil? && !params[:user][:work_position].empty?
     @filtered = @filtered.where("work_position LIKE ?", "%#{params[:user][:work_position]}%")
    end
    @users = @filtered.reorder("name ASC").paginate(page: params[:page], :per_page => 10)
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.remove_resume!
    @user.remove_image!
    @user.save
    @user.destroy
   # flash[:success] = "User deleted."
    @users = User.reorder("name ASC").paginate(page: params[:page], :per_page => 10)
    #redirect_to users_url
  end
  
  def admin
    @user = User.find(params[:id])

    #if @user.admin?
    #  flash[:success] = "Admin Revoked"
    #  @user.update_attribute(:admin,false)
    #else
    #  @user.update_attribute(:admin,true)
    #  flash[:success] = "Admin Added"
    #end
    @user.toggle!(:admin)
    @users = User.reorder("name ASC").paginate(page: params[:page], :per_page => 10)
    #redirect_to users_url
  end
  
  def private_resume
    @user = User.find(params[:id])
    @user.toggle!(:private_resume)
  end
  
  # def remove_prof_pic
  #   @user = User.find(params[:id])
  #   @user.delete :image
  #   redirect_to @user
  # end
  
  # def remove_resume
  #   @user = User.find(params[:id])
  #   @user.delete :resume
  # end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :school, :company, 
                                   :work_position, :password,
                                   :password_confirmation, :image, :resume, :remove_image, :remove_resume, :goal)
    end

  # Before filters
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
end