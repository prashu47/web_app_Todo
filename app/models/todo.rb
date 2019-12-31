# frozen_string_literal: true

class Todo < ApplicationRecord
  # validation
  validates :body, presence: true, length: { minimum: 5 }
  # Associstion
  has_one_attached :avatar
  has_many :comments
  has_many :shares
  has_many :users, through: :shares

  # scope
  scope :todo_search, ->(params) { where('body LIKE ?', "%#{params[:search]}%") }
  # class method to search todo
  def self.search(params)
    p params
    if params[:search].blank?
    else
      @todo = params[:search].downcase # scope.
      @todos = Todo.todo_search(params)
    end
  end

  # class method for delete todo
  def self.destroy(params)
    @todo = Todo.find(params[:id])
    @todo.destroy
  end

  # class method for status_update
  def self.status_update(params)
    @todo = Todo.find(params[:id]) # filter
    @todo.update(active: !@todo.active?)
  end

  # class method for active_inactive status of todo
  def self.active_inactive(params, current_user)
    @todos = current_user.todos.where(active: params[:status] == 'active').order(priority: :desc)
  end
end
