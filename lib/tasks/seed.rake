require 'nokogiri'
require 'open-uri'

namespace :seed do

  desc "Update song data from local itunes"
  task songs: :environment do
    Song.delete_all
    Artist.delete_all
    Album.delete_all

    song = Song.new(
      name: 'Wish you were rich',
      filename: "/'Weird Al' Yankovic/Straight Outta Lynwood/White & Nerdy.mp3"
    )

    song.save

    album = Album.new(
      name: 'All my shit'
    )

    album.save

    artist = Artist.new(
      name: 'Erik Hicks'
    )

    artist.save

    album.songs << song
    song.artist = artist
    artist.songs << song
    artist.albums << album

  end

  desc "Populate Billboard End-Year Top100 Data"
  task top100: :environment do
    (1990..2013).each do |year|
      parse_chart_data(year)
    end
    # parse_chart_data(1982)
  end

  def parse_chart_data(year)
    doc = Nokogiri::HTML(open("http://en.wikipedia.org/wiki/Billboard_Year-End_Hot_100_singles_of_#{year.to_s}"))
    rows = doc.search('.wikitable tr')
    ChartTop100Year.delete_all(["year = ?", year])
    
    rows.each do |row|
      next if row.search('td').empty?

      song_name = nil
      artist_name = nil
      song_id = nil

      data_song = row.search('td')[0].search('a')
      data_artist = row.search('td')[1].search('a')

      # rows are organized differently here
      if row.search('td').count > 2
        data_song = row.search('td')[1].search('a')
        data_artist = row.search('td')[2].search('a')
      end

      if data_song.nil? || data_song.empty?
        # without link
        data_song = row.search('td')[0].text.gsub('"','')
        data_artist = data_artist.text
      else
        # with link
        data_song = data_song.text
        data_artist = data_artist.text
      end
      
      unless data_song.nil? || data_artist.nil?
        song_name = data_song.to_s
        artist_name = data_artist.to_s
      end

      song = find_local_data(song_name, artist_name)

      if song
        song_id = song.id
        puts "#{song_id}: #{song_name} - #{artist_name}"
      else
        puts "?: #{song_name} - #{artist_name}"
      end

      chart_data = ChartTop100Year.create(
        year: year,
        song_id: song_id,
        artist: artist_name,
        title: song_name
      )
    end
  end

  def find_local_data(title, artist)
    song = nil
    artist = Artist.named(artist).first

    if artist
      song = artist.songs.like(title).first
    end

    return song unless song.nil?
    return false
  end

end
