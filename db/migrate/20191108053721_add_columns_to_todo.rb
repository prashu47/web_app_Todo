class AddColumnsToTodo < ActiveRecord::Migration[6.0]
  def change
    add_column :todos, :body, :string
    add_reference :todos, :user
  end
end
