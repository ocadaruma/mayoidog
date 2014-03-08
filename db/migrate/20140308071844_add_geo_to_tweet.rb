class AddGeoToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :latitude, :string
    add_column :tweets, :longitude, :string
  end
end
