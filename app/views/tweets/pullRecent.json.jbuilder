json.extract! @tweet, :content
json.url tweet_url(@tweet, format: :json)
