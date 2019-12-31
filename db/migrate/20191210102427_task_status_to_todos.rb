class TaskStatusToTodos < ActiveRecord::Migration[6.0]
  def change
    add_column :todos, :task_status, :integer, :default => 0
  end
end
