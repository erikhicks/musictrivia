class Album < ActiveRecord::Base
	has_many :songs
	has_one :artist
end
