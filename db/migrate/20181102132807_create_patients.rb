class CreatePatients < ActiveRecord::Migration[5.2]
  def change
    create_table :patients do |t|
      t.string :name, null: false
      t.string :login, null: false, unique: true
      t.string :password_digest
      t.boolean :is_admin, null: false, default: false

      t.timestamps
    end
  end
end
