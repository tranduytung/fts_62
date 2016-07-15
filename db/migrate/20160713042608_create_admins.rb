class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :name
      t.string :chatwork_id
      t.string :remember_digest

      t.timestamps null: false
    end
  end
end
