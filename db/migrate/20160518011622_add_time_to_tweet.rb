class AddTimeToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :time, :string
  end
end
