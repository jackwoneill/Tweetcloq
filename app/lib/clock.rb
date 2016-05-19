require 'clockwork'
require 'net/http'
require File.expand_path('../../../config/boot', __FILE__)

require File.expand_path('../../../config/environment', __FILE__)

module Clockwork
  handler do |job|
    case job
    when 'exec'
      time = Time.now.strftime("%l:%M").gsub(/\s+/, "")
      puts ("\"#{time}\"")

      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = "tEMIRf0snGofkdzdeQXBEYSlb"
        config.consumer_secret     = "oVOQ0xuSQod53YyMZ9ltZsHFVS8wz2yvl6N7L7072yr9Leqy8o"
        config.access_token        = "868385953-9XJj62n9FuNc8xJOBN7TRWeQgZL2Ds9BXxNGLqOg"
        config.access_token_secret = "JBU0G5GjxmiZ1HYopqA39Sa2FpLXIbE7hOp5tsPQRuxB7"
      end

      client.search("\"#{time}\"", result_type: "recent").take(1).collect do |tweet|
        twt = client.oembed(tweet.id).html
        t = Tweet.new(embed: twt, time: time)
        puts tweet.text
        t.save
        $redis.publish('tweets.save', t.to_json)
      end
    end
  end
  every(10.seconds, 'exec')
end