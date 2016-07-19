class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.boolean :is_correct, default: false
      t.references :exam, index: true, foreign_key: true
      t.references :question, index: true, foreign_key: true
      t.references :answer, index: true, foreign_key: true
      t.string :answer_ids

      t.timestamps null: false
    end
  end
end
