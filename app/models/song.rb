class Song < ActiveRecord::Base
	belongs_to :album
	belongs_to :artist

  scope :named, -> (name) { where("lower(name) = ?", name.downcase) }
  scope :like, -> (name) { where("lower(name) LIKE \"%#{name}%\"") }

	def create_clip
		self.create_uuid

		temp_path = "#{Rails.root}/tmp/clip.aiff"
    save_path = "#{Rails.root}/public/audio/#{self.clip}.mp3"
    read_path = MUSIC_SEARCH_DIR + self.filename

    if File.exists? save_path
      return save_path
    end

    if File.exists? read_path
      puts "Converting #{read_path}"
      cmd = "ffmpeg -y -i \"#{read_path}\" -ss 00:00:30 -t 20 \"#{temp_path}\""
      convert = `#{cmd}`
    end

    if File.exists? temp_path
      puts "Clipping and saving to #{save_path}"
      cmd = "ffmpeg -i \"#{temp_path}\" -f mp3 -acodec libmp3lame -ab 128000 -ar 44100 -af afade=t=out:st=18:d=2,afade=t=in:st=0:d=2 \"#{save_path}\""
      clip = `#{cmd}`

      File.delete temp_path
    end

    if (File.exists?(save_path) && File.size(save_path) > 1000)
    	return save_path
    end

    return false
	end

	def create_uuid
		if self.clip.nil?
			self.clip = SecureRandom.uuid
			self.save
		end

		return self.clip
	end

  def url
    "#{PUBLIC_AUDIO_DIR}/#{self.clip}.mp3"
  end
end
