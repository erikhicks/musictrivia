class Api::SongController < ActionController::Base
  
	# Find a random song and save it to the public directory
	# Output: json object with path to song clip
  def random
  	song = Song.first(:offset => rand(Song.count))
  	clip = song.create_clip

  	if clip
  		render json: {
  			success: true,
  			audio: {
          url: "http://#{request.host_with_port}#{song.url}"
        }
  		}.to_json
  	else
  		render json: {
  			sucess: false
  		}.to_json
  	end
  end
  
end
