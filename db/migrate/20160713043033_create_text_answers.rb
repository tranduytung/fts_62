class CreateTextAnswers < ActiveRecord::Migration
  def change
    create_table :text_answers do |t|
      t.string :content
      t.references :result, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
