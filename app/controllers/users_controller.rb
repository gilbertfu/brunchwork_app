class UsersController < ApplicationController
before_action :signed_in_user, only: [:index, :show, :edit, :update, :destroy, :admin, :private_resume, :remove_resume, :remove_prof_pic, :submit_edit_goals]
before_action :correct_user,   only: [:edit, :update, :private_resume, :remove_resume, :remove_prof_pic, :submit_edit_goals]
before_action :admin_user,     only: [:destroy, :admin]
respond_to :html, :js

  def show
    @user = User.find(params[:id])
    @comments = @user.comments.reorder("created_at DESC").paginate(page: params[:page], :per_page => 3)
  end
  
  def new
    if signed_in?
      redirect_to current_user
    end
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      #sign_in @user
      #flash[:success] = "Welcome to brunchwork!"
      #redirect_to @user
      MyMailer.account_activation(@user).deliver
      flash[:info] = "We will send you an email to activate your account soon."
      redirect_to root_url
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
        #update all attributes, and use the old password as password/confirmation
        if @user.update_attributes(:email => params[:user][:email], 
                                   :name => params[:user][:name],
                                   :image => params[:user][:image],
                                   :resume => params[:user][:resume],
                                   :password => params[:user][:old_password],
                                   :password_confirmation => params[:user][:old_password])
            flash[:success] = "Profile Updated"
            redirect_to @user
        else
            flash[:danger] = "Error in updating profile"
            redirect_to edit_user_path(@user)
        end
    else
      flash[:danger] = "Must Provide Correct Password to Update Profile"
      redirect_to edit_user_path(@user)
    end
  end
  
  def index
    @filtered = User.all
    #dummy search variable
    @search = User.new(:email => "dummy@brunchwork.com", 
                       :name => "",
                       :school => "",
                       :company => "",
                       :work_position => "",
                       :password => "password",
                       :password_confirmation => "password")
    #filter on user names
    if !params[:user].nil? && !params[:user][:name].empty?
     @filtered = @filtered.where("name ILIKE ?", "%#{params[:user][:name]}%")
    end
    
    if !params[:user].nil? && !params[:user][:school].empty?
      @filtered = @filtered.joins(:educations).where("educations.school ILIKE '%#{params[:user][:school]}%'")
     #@filtered = @filtered.where("school LIKE ?", "%#{params[:user][:school]}%")
    end
    
    if !params[:user].nil? && !params[:user][:company].empty?
      @filtered = @filtered.joins(:employments).where("employments.company ILIKE '%#{params[:user][:company]}%'")
     #@filtered = @filtered.where("company LIKE ?", "%#{params[:user][:company]}%")
    end
    
    if !params[:user].nil? && !params[:user][:work_position].empty?
      @filtered = @filtered.joins(:employments).where("employments.title ILIKE '%#{params[:user][:work_position]}%'")
     #@filtered = @filtered.where("work_position LIKE ?", "%#{params[:user][:work_position]}%")
    end
    #@filtered = @filtered.uniq
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
    @user.toggle!(:admin)
    @users = User.reorder("name ASC").paginate(page: params[:page], :per_page => 10)
    #redirect_to users_url
  end
  
  def private_resume
    @user = User.find(params[:id])
    @user.toggle!(:private_resume)
  end
  
  def add_employment
    @employment = current_user.employments.build if signed_in?
  end
  
  def add_education
    @education = current_user.educations.build if signed_in?
  end
  
  def edit_goals
    #do nothing yet
    @user = current_user
  end
  
  def submit_edit_goals
    @user = current_user
    @user.update_attribute(:goal, params[:user][:goal]);
  end
  
  def remove_resume
    @user = current_user
    @user.remove_resume!
    @user.update_attribute(:resume,"");
    @user.save
    redirect_to edit_user_path(@user)
  end
  
  def remove_prof_pic
    @user = current_user
    @user.remove_image!
    @user.update_attribute(:image,"");
    @user.save
    redirect_to edit_user_path(@user)
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :school, :company, 
                                   :work_position, :password,
                                   :password_confirmation, :image, :resume, :goal)
    end

  # Before filters
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
end