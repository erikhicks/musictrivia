#!/usr/bin/ruby

MUSIC_DIR = "/Users/hickse/Music/iTunes/iTunes\ Media/Music"
TEMP_DIR = "/Users/hickse/code/musictrivia/temp"
WEB_DIR = "/Users/hickse/code/musictrivia/clips"

TEST_ARTIST = "/Genesis"
TEST_ALBUM = "/Genesis"
TEST_SONG = "/Home\ By\ The\ Sea.m4a"
TEST_PATH = MUSIC_DIR + TEST_ARTIST + TEST_ALBUM + TEST_SONG

SAVE_NAME = TEST_ARTIST + TEST_ALBUM + TEST_SONG
TEMP_LOCATION = TEMP_DIR + '/' + SAVE_NAME.downcase.gsub('\ ','_').gsub('/','_') + '.aiff'
SAVE_LOCATION = WEB_DIR + '/' + SAVE_NAME.downcase.gsub('\ ','_').gsub('/','_') + '.mp3'

puts "Opening " + TEST_PATH
`ffmpeg -y -i "#{TEST_PATH}" -ss 00:00:30 -t 10 "#{TEMP_LOCATION}"`

puts "Saving " + SAVE_LOCATION
`ffmpeg -i "#{TEMP_LOCATION}" -f mp3 -acodec libmp3lame -ab 64000 -ar 44100 -af afade=t=out:st=8:d=2,afade=t=in:st=0:d=2 "#{SAVE_LOCATION}"`