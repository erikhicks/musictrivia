window.Game = {}

(->
	user = {
		name: 'Erik'
	}

	type = {

	}

	Game.init = ->
		$('.user').html user.name
		
)()

$(document).ready ->
	Game.init()