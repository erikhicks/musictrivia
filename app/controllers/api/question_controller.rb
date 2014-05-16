class Api::QuestionController < ActionController::Base
  
  # Generates a question with given criteria
	def new
    question = nil
    song = nil

    question_type = TriviaQuestionType.model("Artist").property("name").first
    
    # Default is random
    if (params[:year] && (1960..2013).include?(params[:year].to_i))
      chart_results = ChartTop100Year.year(params[:year].to_i).available_songs
      if chart_results.length > 0
        song = chart_results.sample.song
      end
    else
      song = Song.first(:offset => rand(Song.count))
    end
    
    clip = song.create_clip
    output_question(question_type, song)
  end

  private

  def output_question(question_type, song)
    if question_type && song
      question = TriviaQuestion.new()
      question.uuid = SecureRandom.uuid
      question.trivia_question_type = question_type
      question.album = song.album
      question.artist = song.artist
      question.song = song
    end

    if question && song
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
