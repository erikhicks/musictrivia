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

  end
end
