class CommentsController < ApplicationController
  before_action :user_must_be_signed_in

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id if user_signed_in?
    @comment.image_id = params[:comment][:image]
    @comment.content = params[:comment][:content]
    if @comment.save
      redirect_to image_path(@comment.image), notice: "Comment created!"
    else
      redirect_to :back, alert: "Failed to create comment."
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :image_id, :user_id)
    end
end
