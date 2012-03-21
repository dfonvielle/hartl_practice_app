class AddPasswordDigestToCoolUsers < ActiveRecord::Migration
  def change
    add_column :cool_users, :password_digest, :string
  end
end
