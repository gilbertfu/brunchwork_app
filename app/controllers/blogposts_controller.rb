class BlogpostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :new, :show, :edit, :update]
  before_action :admin_user, only: [:create, :destroy, :new, :edit, :update]

  def index
    @blogposts = Blogpost.paginate(page: params[:page], :per_page => 6)
  end
  
  def show
    @blogpost = Blogpost.find(params[:id])
    @photos = @blogpost.photos.all
    @comments = @blogpost.comments.all
    @comment = @comment = Comment.new
  end
  
  def new
    @blogpost = Blogpost.new
    @photos = @blogpost.photos.build
  end
  
  def create
    @blogpost = Blogpost.new(blogpost_params)
    if @blogpost.save
      if !params[:photos].nil?
        params[:photos]['image'].each do |a|
          @photos = @blogpost.photos.create!(:image => a, :imageable_id => @blogpost.id)
        end
      end
      flash[:success] = "Blogpost created!"
      redirect_to blogposts_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @blogpost = Blogpost.find(params[:id])
    for i in 1..@blogpost.photos.count
      @blogpost.photos[i-1].remove_image!
    end
    @blogpost.save
    @blogpost.destroy
    flash[:success] = "Blogpost deleted."
    redirect_to blogposts_url
  end
  
  def edit
    @blogpost = Blogpost.find(params[:id])
  end
  
  def update
    @blogpost = Blogpost.find(params[:id])
    #update all attributes
    if @blogpost.update_attributes(blogpost_params)
      flash[:success] = "Profile updated"
      redirect_to @blogpost
    else
      render 'edit'
    end
  end

  private

    def blogpost_params
      params.require(:blogpost).permit(:content, :title, photos_attributes: [:id, :imageable_id, :image])
    end
end
  