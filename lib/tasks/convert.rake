require 'pry'
require 'json'

namespace :convert do

  desc "Update song data from local itunes"
  task clip_data: :environment do
    Song.delete_all
    Artist.delete_all
    Album.delete_all
    read_dir MUSIC_SEARCH_DIR
  end

  task clip_audio: :environment do
    songs = Song.all

    songs.each do |song|
      song.create_clip
    end
  end

  def read_dir(dir)
    temp_file = "#{Rails.root}/tmp/clip.json"

    Dir.glob("#{dir}/*").each_with_object({}) do |f, h|
      f = f.gsub('$','\$')

      if File.file?(f)
        cmd = "ffprobe -show_format \"#{f}\" -print_format json > \"#{temp_file}\""
        result = `#{cmd}`

        # Create a temporary file with JSON output for processing
        if File.exists? temp_file
          json = JSON.parse( IO.read(temp_file) )

          # Song looks good, handle adding it to the database from here
          if json["format"] && json["format"]["tags"]
            save_song_data(json, f)
          end
          
          File.delete temp_file
        end
      elsif File.directory?(f)
        read_dir(f)
      end
    end

  end

  def save_song_data(json, filename)
    existing_album = nil
    artist = json["format"]["tags"]["artist"]
    album = json["format"]["tags"]["album"]
    title = json["format"]["tags"]["title"]

    existing_artist = Artist.find_or_create_by_name artist

    existing_artist.albums.each do |artist_album|
      if artist_album.name == album
        existing_album = artist_album 
      end
    end

    if existing_album.nil?
      existing_album = Album.new(name: album)
    end

    existing_artist.albums << existing_album

    song = Song.new(name: title, filename: filename.gsub(MUSIC_SEARCH_DIR, ''), clip: SecureRandom.uuid)

    song.artist = existing_artist
    existing_album.songs << song
    existing_artist.songs << song

    song.save
    existing_album.save
    existing_artist.save

    puts "Saving: #{artist} - \"#{title}\" - #{album}"
  end

end
