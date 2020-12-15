class AddUser < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :password
      t.timestamps
    end
    add_column :users, :role, :integer, default: 0
  end
end
