require 'dotenv/load'

require 'ostruct'
require 'pry'
require 'twitter'
require 'open-uri'
require 'logger'
require 'open-uri'

require 'erb'
include ERB::Util

logger = Logger.new(STDERR)

ads = []

File.open("./ads.txt").each do |line|
  ota = OpenStruct.new
  ota.ad = true
  ota.item_source = line.chomp
  ota.yuru_chara = false

  ads << ota
end

otakus = Marshal.load(STDIN.read)
otakus.each do |ota|
  profile_image_path = "images/twitter_#{ota.tw_id}_#{File.extname(ota.profile_image_url)}"

  open("./yufitter/#{profile_image_path}", 'wb') do |output|
    output.write(ota.profile_image)
  end

  ota.profile_image = profile_image_path
end

ad_freq = (otakus.size / ads.size).floor

ads.each_with_index do |ad, i|
  index = ad_freq + (ad_freq * i) + i
  logger.debug index
  otakus.insert(index, ad) #均等に差し込む
end

open("./yufitter/js/include2.json", 'w') do |output|
  json_text = ERB.new(File.open('./include2.json.erb').read).result
  output.write(JSON.pretty_generate(JSON.parse(json_text)))
end

open("./yufitter/urukyara.html", 'w') do |output|
  output.write(ERB.new(File.open('./urukyara.html.erb').read).result)
end

open("./yufitter/otalist.html", 'w') do |output|
  output.write(ERB.new(File.open('./otalist.html.erb').read).result)
end
