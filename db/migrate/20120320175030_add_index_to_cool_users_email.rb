class AddIndexToCoolUsersEmail < ActiveRecord::Migration
  def change
    add_index :cool_users, :email, unique: true
  end
end
