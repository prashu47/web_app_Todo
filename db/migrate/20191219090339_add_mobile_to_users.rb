class AddMobileToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :mobile, :string limit => 10
  end
end
