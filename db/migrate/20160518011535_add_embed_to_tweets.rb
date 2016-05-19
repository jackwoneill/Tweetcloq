class AddEmbedToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :embed, :string
  end
end
