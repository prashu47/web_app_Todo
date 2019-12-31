# frozen_string_literal: true

class TodosController < ApplicationController
  respond_to :js
  respond_to :html

  # method for index page
  def index
    @todo = current_user.todos.where(active: true)
    # @todos = Share.share_todo(current_user,current_priority)
  end

  # new method for todo creation
  def new
    @todo = Todo.new
  end

  # method for creation of new todo
  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      @share = current_user.shares.build(todo_id: @todo.id, is_owner: true)
      @share.update_priority if @share.save
    end
  end

  def change_status
    p params
  end

  # method to show the progress of todo by using progress bar
  def track_status
    p params
    @todo = Todo.find(params[:id])
    @todo.update(task_status: params[:new_status])
  end

  # method to calling search method from model
  def search
    @todos = Todo.search(params)
  end

  # method for ative and inactive todo status
  def status_update
    @todo = Todo.find(params[:id])
    @todo.update(active: !@todo.active?)
  end

  def todo_status
    p params
  end

  # method to delete todo
  def destroy
    @todo = Todo.destroy(params)
  end

  # method to show todos,comments,user and shared_users
  def show
    @todo = Todo.find(params[:id])
    @comment = @todo.comments
    @user = User.all
    @shared_users = User.joins(:shares).select('user_name,user_id').where('todo_id=?and is_owner=false', params[:id])
  end

  # method to change position of todo from up and down
  def change_position
    @todo = Todo.find(params[:id])
    position = params[:direction]
    if position == 'up'
      Share.up_position(params)
      @arrow = 'up'
    end
    if position == 'down'
      Share.position_down(params)
      @arrow = 'down'
    end
    @todos = current_user.todos.where(active: @todo.active?).order(priority: :desc)
    respond_to :js
  end

  # method for active and inactive todos
  def active_inactive
    @todos = Todo.active_inactive(params, current_user)
    respond_to :js
  end

  # method to update priority of todo
  def update_priority
    Todo.order(:updated_at).each.with_index(1) do |todo, index|
      todo.update_column :priority, index
    end
  end
  # params

  private

  def todo_params
    params.require(:todo).permit(:body).merge(user_id: current_user)
  end

  private

  def user_profile_params
    params.require(:user).permit(:name, :email, :mobile)
  end
end
