class CreateExaminations < ActiveRecord::Migration[5.2]
  def change
    create_table :examinations do |t|
      t.string :name, null: false
      t.string :path, null: false
      t.timestamp :examinated_at
      t.references :patient, foreign_key: {on_delete: :cascade, on_update: :cascade}

      t.timestamps
    end
  end
end
