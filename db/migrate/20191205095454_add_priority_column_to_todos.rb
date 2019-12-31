class AddPriorityColumnToTodos < ActiveRecord::Migration[6.0]
  def change
    add_column :todos, :priority, :bigint
  end
end
