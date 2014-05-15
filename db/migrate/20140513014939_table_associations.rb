class TableAssociations < ActiveRecord::Migration
  def change
  	add_column :songs, :artist_id, :integer
  	add_column :songs, :album_id, :integer

  	create_table :artists_songs do |t|
      t.integer :song_id
      t.integer :artist_id

      t.timestamps
    end

    create_table :albums_artists do |t|
      t.integer :artist_id
      t.integer :album_id

      t.timestamps
    end

  end
end
