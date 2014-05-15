#!/usr/bin/ruby

require 'pry'
require 'json'

SEARCH_DIR = "/Users/hickse/Music/iTunes/iTunes\ Media/Music"

def read_dir(dir)
	Dir.glob("#{dir}/*").each_with_object({}) do |f, h|
		if File.file?(f)
			cmd = "ffprobe -show_format \"#{f}\" -print_format json"
			puts cmd
			result = `#{cmd}`
			artist = json["format"]["tags"]["artist"]
			album = json["format"]["tags"]["album"]
			title = json["format"]["tags"]["title"]
			puts "#{artist} - \"#{title}\" - #{album}"
		elsif File.directory?(f)
			read_dir(f)
		end
	end
end

read_dir SEARCH_DIR