class AddImageUrlAndCreatedTimeToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :time, :string
    add_column :tweets, :image_url, :string
  end
end
