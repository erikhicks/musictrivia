class Artist < ActiveRecord::Base
	has_and_belongs_to_many :songs
	has_and_belongs_to_many :albums

	scope :named, -> (name) { where("lower(name) = ?", name.downcase) }
end
