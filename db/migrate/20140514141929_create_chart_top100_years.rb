class CreateChartTop100Years < ActiveRecord::Migration
  def change
    create_table :chart_top100_years do |t|
      t.integer :year
      t.integer :song_id
      t.string :title
      t.string :artist

      t.timestamps
    end
  end
end
