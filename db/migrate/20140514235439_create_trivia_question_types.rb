class CreateTriviaQuestionTypes < ActiveRecord::Migration
  def change
    create_table :trivia_question_types do |t|
      t.string :text
      t.string :answer_model
      t.string :answer_property

      t.timestamps
    end
  end
end
