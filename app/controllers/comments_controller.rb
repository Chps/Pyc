class CommentsController < ApplicationController
  before_action :user_must_be_signed_in

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user if user_signed_in?
    if @comment.save
      redirect_to image_path(@comment.image), notice: "Comment created!"
    else
      redirect_to :back, alert: "Failed to create comment."
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :image_id)
    end
end
