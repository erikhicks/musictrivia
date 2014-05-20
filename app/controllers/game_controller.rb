class GameController < ApplicationController
  def index
  end

  def play
  	@message = ""

  	type = params[:type]

  	case type
  	when "by_year"
  		@message = ""
  	end

  end

  def choose

  end

  def by_year_start
    @year_chosen = params[:year]
    @current_song = get_random_song_by_range(@year_chosen.to_i)
    @current_song.create_clip

    @current_question = TriviaQuestion.create_with_song(
      @current_song,
      TriviaQuestionType.find_by_text('name the artist')
    )
  end

  def by_year_answer
    answer = params[:answer]
    question = TriviaQuestion.find_by_uuid(params[:question])

    @correct_answer = question.try_answer(answer)
    by_year_start
  end

  private

  def get_random_song_by_range(year_chosen)
    songs_from_charts = ChartTop100Year.year_range(year_chosen-1, year_chosen+1).available_songs
    random = Random.rand(songs_from_charts.length)
    return songs_from_charts[random].song
  end
end
