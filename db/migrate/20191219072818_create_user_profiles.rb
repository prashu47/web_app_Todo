class CreateUserProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_profiles do |t|
      t.text :name
      t.string :email
      t.integer :mobile
      t.string :user_name

      t.timestamps
    end
  end
end
