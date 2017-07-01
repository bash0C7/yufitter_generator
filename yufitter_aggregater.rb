require 'dotenv/load'

require 'csv'
require 'ostruct'
require 'pry'
require 'twitter'
require 'open-uri'
require 'logger'


logger = Logger.new(STDERR)

twitter_client = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
  config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
  config.access_token = ENV['TWITTER_ACCESS_TOKEN']
  config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
end

otakus = []

CSV.foreach("./result.tsv", col_sep: "\t", headers: true) do |row|
  ota = OpenStruct.new
  ota.ad = false
  ota.tw_id = row[1]
  begin
    ota_tw = twitter_client.user(ota.tw_id)
    logger.info ota.tw_id
  rescue Twitter::Error::NotFound => e
    logger.warn "#{e}: #{ota.tw_id}"
    next
  end
  ota.name = ota_tw.name

  url = ota_tw.profile_image_url_https.to_s.gsub('_normal.', '.')
  profile_image = "images/twitter_#{ota.tw_id}_#{File.extname(url)}"
  local_profile_image = "./yufitter/#{profile_image}"

  open(local_profile_image, 'wb') do |output|
    open(url) do |data|
      output.write(data.read)
    end
  end

  ota.profile_image = profile_image
  ota.message = row[2]
  ota.url = row[3]
  ota.yuru_chara = (row[5] == "TRUE")

  otakus << ota

  sleep 1
end

puts Marshal.dump(otakus)