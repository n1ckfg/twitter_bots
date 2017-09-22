# encoding: utf-8
require "rubygems"
require "twitter"

rClient = Twitter::REST::Client.new do |config|
  config.consumer_key = "YOUR_CONSUMER_KEY"
  config.consumer_secret = "YOUR_CONSUMER_SECRET"
  config.access_token = "YOUR_ACCESS_TOKEN"
  config.access_token_secret = "YOUR_ACCESS_TOKEN_SECRET"
end

sClient = Twitter::Streaming::Client.new do |config|
  config.consumer_key = "YOUR_CONSUMER_KEY"
  config.consumer_secret = "YOUR_CONSUMER_SECRET"
  config.access_token = "YOUR_ACCESS_TOKEN"
  config.access_token_secret = "YOUR_ACCESS_TOKEN_SECRET"
end

me = "YOUR_FULL_USER_NAME" # prevent DMing yourself
      
sClient.user do |object|
if object.is_a? Twitter::Streaming::Event and object.name==:follow
  user = object.source
  if user.name != me
    rClient.create_direct_message user, "Hi, [ #{object.source.name} ]--MESSAGE_TEXT"
  end
end
end

