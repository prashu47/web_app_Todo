# frozen_string_literal: true

class CommentsController < ApplicationController
  respond_to :js
  # method for comments creation for todo by users
  def create
    @todo = Todo.find(params[:todo_id])
    @comment = @todo.comments.create(comment_params.merge(user_id: current_user.id))
    redirect_to todo_path(@todo)
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :todo_id)
  end
end
