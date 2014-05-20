class TriviaQuestion < ActiveRecord::Base
	belongs_to :trivia_question_type
	belongs_to :album
	belongs_to :artist
	belongs_to :song

	def self.create_with_song(song, type)
		return self.create(
			song: song,
			artist: song.artist,
			uuid: SecureRandom.uuid,
			trivia_question_type: type
		)
	end

	def try_answer(answer)
		case self.trivia_question_type.answer_model
		when "Artist"
			self.is_correct = self.artist.name.downcase === answer.downcase ? true : false
		end

		self.save

		return self.is_correct
	end
end
