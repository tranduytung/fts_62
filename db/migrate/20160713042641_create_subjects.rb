class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :content
      t.integer :number_of_questions
      t.integer :duration

      t.timestamps null: false
    end
  end
end
