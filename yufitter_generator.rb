require 'dotenv/load'

require 'csv'
require 'erb'
require 'ostruct'
require 'pry'
require 'twitter'
require 'open-uri'
Twitter.configure do |cnf|
    cnf.consumer_key    = ENV['TWITTER_CONSUMER_KEY']
    cnf.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
end
@twitter = Twitter::Client.new(
                               :oauth_token => ENV['TWITTER_OAUTH_TOKEN'],
                               :oauth_token_secret => ENV['TWITTER_OAUTH_TOKEN_SECRET']
                               )

otakus = []

CSV.foreach("./result.tsv", col_sep: "\t", headers: true) do |row|
  ota = OpenStruct.new
  ota.tw_id = row[1]
  begin
    ota_tw = @twitter.user(ota.tw_id)
  rescue Twitter::Error::NotFound => e
    STDERR.puts "#{e}: #{ota.tw_id}"
    next
  end
  ota.name = ota_tw.name
  ota.profile_image = ota_tw.profile_image_url_https
  ota.message = row[2]
  ota.url = row[3]
  otakus << ota
  sleep 1
end

# はめ込み
ERB.new(File.open('./yufitter.erb').read).run
