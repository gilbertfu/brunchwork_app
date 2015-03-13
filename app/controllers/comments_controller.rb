class CommentsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :comment_correct_user,   only: :destroy

  def index
  end

  def create
    @blogpost = Blogpost.find(params[:blogpost_id])
    @comment = @blogpost.comments.create(comment_params)
    @comment.user_id = current_user.id #or whatever is you session name
    if @comment.save
      redirect_to @blogpost
    else
      flash.now[:danger] = "Error, Comment must have content and less than 500 characters"
      flash.keep(:danger)
      redirect_to @blogpost
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @user = User.find_by(:id => @comment.user_id)
    @comment.destroy
    redirect_to @user, status: 303
  end
  
  private

    def comment_params
      params.require(:comment).permit(:content)
    end

    def comment_correct_user
      #if not admin user or user who created the post
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end
end