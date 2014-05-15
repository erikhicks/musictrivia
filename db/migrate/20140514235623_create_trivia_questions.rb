class CreateTriviaQuestions < ActiveRecord::Migration
  def change
    create_table :trivia_questions do |t|
      t.string :uuid
      t.integer :trivia_question_type_id
      t.integer :user_id
      t.integer :song_id
      t.integer :album_id
      t.integer :artist_id
      t.boolean :is_correct

      t.timestamps
    end
  end
end
