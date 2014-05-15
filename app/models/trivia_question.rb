class TriviaQuestion < ActiveRecord::Base
	belongs_to :trivia_question_type
	belongs_to :album
	belongs_to :artist
	belongs_to :song
end
