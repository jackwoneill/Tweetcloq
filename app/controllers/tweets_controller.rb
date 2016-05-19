class TweetsController < ApplicationController
  include ActionController::Live
  skip_before_filter  :verify_authenticity_token



  # GET /tweets
  # GET /tweets.json
  def index
    @tweet = Tweet.last
  end



  def events
    response.headers['Content-Type'] = 'text/event-stream'
    redis = Redis.new
    redis.subscribe('tweets.save', 'heartbeat') do |on|
      on.message do |event, data|
        response.stream.write("data: #{data}\n\n")
      end
    end

  rescue IOError
    logger.info "Stream Closed"
  ensure
    redis.quit
    response.stream.close
  end


  # GET /tweets/new
  
  # DELETE /tweets/1
  # DELETE /tweets/1.json

  private
    # Use callbacks to share common setup or constraints between actions.
    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:embed, :time)
    end
end
