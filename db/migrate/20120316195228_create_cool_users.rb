class CreateCoolUsers < ActiveRecord::Migration
  def change
    create_table :cool_users do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
