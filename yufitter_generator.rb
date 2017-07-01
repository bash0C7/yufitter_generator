require 'dotenv/load'

require 'erb'
require 'ostruct'
require 'pry'
require 'logger'
require 'json'
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
  local_profile_image = "./yufitter/images/twitter_#{ota.tw_id}_#{File.extname(ota.profile_image_url)}"

  open(local_profile_image, 'wb') do |output|
    output.write(ota.profile_image)
  end

  ota.profile_image = local_profile_image
end

ad_freq = (otakus.size / ads.size).floor

ads.each_with_index do |ad, i|
  index = ad_freq + (ad_freq * i) + i
  logger.info index
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
