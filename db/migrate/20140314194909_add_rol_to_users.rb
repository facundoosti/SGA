class AddRolToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rol, :string
  end
end
