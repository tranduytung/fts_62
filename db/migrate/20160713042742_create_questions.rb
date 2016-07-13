class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :content
      t.integer :question_type, default: 0
      t.boolean :is_approved, default: false
      t.references :subject, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
