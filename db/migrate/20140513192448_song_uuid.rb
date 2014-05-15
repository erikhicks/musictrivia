class SongUuid < ActiveRecord::Migration
  def change
  	add_column :songs, :clip, :string
  end
end
