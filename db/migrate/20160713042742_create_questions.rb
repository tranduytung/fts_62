class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :content
      t.integer :question_type, default: 0
      t.integer :status, default: 0
      t.references :subject, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
