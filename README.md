<snippet>
  <content><
# Tweetcloq
Created to explore Redis as a way for both temp storage and pub/sub. This is a clock that utilizes the Twitter API to display the time. Displayed in web interface. Not currently live anywhere, however feel free to initialize on your local machine. Requires Redis to use.

#Now
Initially created before the streaming API was available to the public. Now that the Streaming API is publicly available, this would be much simpler, as instead of timed searching, one could simply pull from the Stream/Sample tweets containing the time, and pub/sub on that event
]]></content>
  <tabTrigger>readme</tabTrigger>
</snippet>