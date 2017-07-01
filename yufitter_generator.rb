require 'dotenv/load'

require 'erb'
require 'ostruct'
require 'pry'
require 'open-uri'
require 'logger'
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
ad_freq = (otakus.size / ads.size).floor

ads.each_with_index do |ad, i|
  index = ad_freq + (ad_freq * i) + i
  logger.info index
  otakus.insert(index, ad) #均等に差し込む
end

# はめ込み
ERB.new(File.open('./yufitter.erb').read).run

puts "==============================================================="

ERB.new(File.open('./urukyara.erb').read).run

puts "==============================================================="

ERB.new(File.open('./otalist.erb').read).run
