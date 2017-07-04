require 'dotenv/load'

require 'csv'
require 'ostruct'
require 'pry'
require 'twitter'
require 'open-uri'
require 'logger'
require 'open-uri'

logger = Logger.new(STDERR)

twitter_client = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
  config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
  config.access_token = ENV['TWITTER_ACCESS_TOKEN']
  config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
end

otakus = []

CSV.foreach("./result.tsv", col_sep: "\t", headers: true, quote_char: "\0") do |row|
  next if (row[9] == "TRUE")

  ota = OpenStruct.new
  ota.ad = false
  ota.tw_id = row[1]
  ota.timestamp = row[0]
  begin
    ota_tw = twitter_client.user(ota.tw_id)
    logger.debug ota.tw_id

    ota.name = ota_tw.name

    url = ota_tw.profile_image_url_https.to_s.gsub('_normal.', '.')
    begin
      open(url) {|data| ota.profile_image = data.read}
    rescue OpenURI::HTTPError => e
      logger.info  "#{e}: #{url}"

      url = ota_tw.profile_image_url_https
      begin
        open(url) {|data| ota.profile_image = data.read}
      rescue OpenURI::HTTPError => e
        logger.warn  "#{e}: #{url}"
      end
    end
    ota.profile_image_url = url
  rescue Twitter::Error::NotFound => e
    logger.warn "#{e}: #{ota.tw_id}"
    ota.name = ota.tw_id
    ota.profile_image_url = "https://abs.twimg.com/sticky/default_profile_images/default_profile_400x400.png"
  end

  ota.message = row[2]
  ota.contents_path = row[7]
  ota.contents_path_extension = File.extname(ota.contents_path) unless ota.contents_path.nil?
  ota.yuru_chara = (row[5] == "TRUE")

  otakus << ota

  sleep 0.4
end

puts Marshal.dump(otakus)
