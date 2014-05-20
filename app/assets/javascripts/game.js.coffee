window.Game = {}

(->
	user = {
		name: 'Erik'
	}

	type = {

	}

	state = {
		played_songs: [],
		year_chosen: null
	}

	audio = null;

	Game.init = ->
		$('.user').html user.name

	Game.start = ->		
		$('audio').remove('embed')

		if this.audio
			this.audio.pause()
			setTimeout ->
				Game.audio = new Audio Game.state.current_song
				Game.audio.play()
			, 1500
		else
			this.audio = new Audio Game.state.current_song
			this.audio.play();

	Game.state = state
	Game.audio = audio

)()

$(document).ready ->
	Game.init()