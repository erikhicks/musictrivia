class Api::QuestionController < ActionController::Base
  
  # Generates a question with random criteria
	def new
    question = nil
    artist = nil
    album = nil
    song = nil

    question_type = TriviaQuestionType.model("Artist").property("name").first
    song = Song.first(:offset => rand(Song.count))
    clip = song.create_clip
    
    if question_type
      question = TriviaQuestion.new(
        uuid: SecureRandom.uuid,
        trivia_question_type: question_type,
        album: album,
        artist: artist,
        song: song
      )
    end

    if question
     question.save

     render json: {
       success: true,
       question: {
         id: question.uuid,
         text: question_type.text
       },
       audio: {
         url: "http://#{request.host_with_port}#{song.url}"
       }
     }
    else
      render json: {
        success: false
      }
    end
  end


end
