# frozen_string_literal: true

class Share < ApplicationRecord
  # Associstion
  belongs_to :user
  belongs_to :todo
  # scopes
  scope :share_todo, ->(params) { select('user_id').where('todo_id=?and is_owner=false', params[:todo_id]) }
  scope :next_priority_asc, ->(current_priority) { where('priority > ? and is_owner=true', current_priority).order(priority: :asc).limit(1)[0] }
  scope :next_priority_desc, ->(current_priority) { where('priority < ? and is_owner=true', current_priority).order(priority: :desc).limit(1)[0] }

  # method for share todo the users
  def self.create_share(params)
    @shared_users = params[:user_array]
    @current_share_user = Share.share_todo(params)
    @shared_users.each do |user|
      share = Share.new(user_id: user.to_i, todo_id: params[:todo_id], is_owner: false)
      not_shared = @current_share_user.find_by(user_id: user.to_i).nil?
      if not_shared
        share = Share.new(user_id: user, todo_id: params[:todo_id], is_owner: false)
        share.save
      end
    end
   end

  # method to update priority
  def update_priority
    Share.order(:priority).each.with_index(0) do |share, index|
      share.update_column :priority, index
    end
  end

  # method for position up
  def self.up_position(params)
    if Todo.find(params[:id]).active?
      current_todo = Share.find_by_todo_id(params[:id])
      # current_priority = current_todo.priority
      current_priority = current_todo[:priority]
      next_priority = Share.next_priority_asc(current_priority)
      # ctodo= current_todo
      new_current_todo = current_todo.update(priority: next_priority.priority)
      new_next_priority = next_priority.update(priority: current_priority)
    else
      current_todo = Share.find_by_todo_id(params[:id])
      # current_priority = current_todo.priority
      current_priority = current_todo[:priority]
      next_priority = Share.next_priority_asc(current_priority)
      # ctodo= current_todo
      new_current_todo = current_todo.update(priority: next_priority.priority)
      new_next_priority = next_priority.update(priority: current_priority)
    end
 end

  # method for position down of todo
  def self.position_down(params)
    if Todo.find(params[:id]).active?
      current_todo = Share.find_by_todo_id(params[:id])
      # current_priority = current_todo.priority
      current_priority = current_todo[:priority]
      next_priority = Share.next_priority_desc(current_priority)
      # ctodo= current_todo
      new_current_todo = current_todo.update(priority: next_priority.priority)
      new_next_priority = next_priority.update(priority: current_priority)
    else
      current_todo = Share.find_by_todo_id(params[:id])
      # current_priority = current_todo.priority
      current_priority = current_todo[:priority]
      # ctodo= current_todo
      next_priority = Share.next_priority_desc(current_priority)

      new_current_todo = current_todo.update(priority: next_priority.priority)
      new_next_priority = next_priority.update(priority: current_priority)
    end
  end
end
