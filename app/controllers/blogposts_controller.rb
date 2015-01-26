class BlogpostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :new, :show]
  before_action :admin_user, only: [:create, :destroy, :new]

  def index
    @blogposts = Blogpost.paginate(page: params[:page], :per_page => 5)
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
    Blogpost.find(params[:id]).destroy
    flash[:success] = "Blogpost deleted."
    redirect_to blogposts_url
  end

  private

    def blogpost_params
      params.require(:blogpost).permit(:content, :title, photos_attributes: [:id, :imageable_id, :image])
    end
end
  