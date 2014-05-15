class ChartTop100Year < ActiveRecord::Base
	has_one :song, foreign_key: "id", primary_key: "song_id"
	has_many :songs, foreign_key: "id", primary_key: "song_id"

	scope :year, -> (year) { where(year: year) }
	scope :available_songs, -> { joins(:songs).where('chart_top100_years.song_id = songs.id') }
end
