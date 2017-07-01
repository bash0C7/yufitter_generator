# yufitter_generator

## Setup

- save result.tsv to project root
  - 事前に改行を|に変換すること
- save ads.txt to project root
  - 1行ごとにHTMLのスニペット（信頼できるものと扱います）
- create .env

```
TWITTER_CONSUMER_KEY=xxxxxxxxxxxxxxxxxx
TWITTER_CONSUMER_SECRET=xxxxxxxxxxxxxxxxxx
TWITTER_ACCESS_TOKEN=xxxxxxxxxxxxxxxxxx
TWITTER_ACCESS_TOKEN_SECRET=xxxxxxxxxxxxxxxxxx
```

### result.tsvサンプル

一行目はカラム名が入っています。

```
タイムスタンプ	TwitterのID（＠は不要です）	お祝いメッセージ	画像、動画URL		ゆるキャラフラグ	備考
2017/06/14 0:40:28	bash0C7	おめでとうだよ〜〜〜〜	https://pbs.twimg.com/media/DCll4p3V0AA3xtd.jpg:large		TRUE	
```

画像URLカラムは手動対応の加減で後ろのカラムにずらすかも。

### ads.txtサンプル

広告の"itemSource"HTMLスニペットを1行1アイテムで保存

```
<div class='wrapotaku'><ul><li><img src='images/twitter_promo_.jpg'></li><li><div class='name'>どうせ【ボッチ】なんでしょ委員会</div><div class='message'>＼やったーーー☆これでボッチからの脱出だーー！！／<br><br>毎年毎年お誕生日だってのにボッチでいる、いわゆる【ボッチ生誕】を迎えている方に朗報です。<br>なんと今年からはイケメンがあなたのためにバースデーソングを歌って盛り上げてくれます♪<br>これで今までの涙とはまた違った涙を流すことに☆</div><div class='otaimages'><a href='/images/520252618.376131.mp4' target='_blank'><img src='/images/banner01.jpg'></a></div><div class='promo'>プロモーション</div></li></ul></div><!-- /wrapotaku -->
<div class='wrapotaku'><ul><li><img src='images/twitter_promo_.jpg'></li><li><div class='name'>どうせ【ボッチ】なんでしょ委員会</div><div class='message'>素敵な出会い、イヤ、『愛』に飢えてませんか？<br>現在様々な出会い系サイトがありますが「いい出会いがあった♪」って聞きませんよね！<br>DE愛.comは違います！！必ず素敵な人、いや、この人↘に逢えます！！　必ず。<br>さあ、出会いたい人もそうでない人も今すぐクリック！！！</div><div class='otaimages'><a href='https://twitter.com/nagekinoumi'><img src='/images/banner02.jpg'></a></div><div class='promo'>プロモーション</div></li></ul></div><!-- /wrapotaku -->
<div class='wrapotaku'><ul><li><img src='images/twitter_promo_.jpg'></li><li><div class='name'>どうせ【ボッチ】なんでしょ委員会</div><div class='message'>どうせ【ボッチ】なんでしょ委員会会長の「凡チェキおじさん」が美術展を開催中！！<br>今回のテーマはズバリ『ゆっふぃー』。<br>今まで描いてきたゆっふぃープラス新作を1枚公開しちゃいます！！<br>この機会をお見逃しなく！！<br>開催期間：2080年7月7日まで</div><div class='otaimages'><a href='bon.html' target='_blank'><img src='/images/banner03.jpg'></a></div><div class='promo'>プロモーション</div></li></ul></div><!-- /wrapotaku -->
```

## Run

```sh
bundle exec ruby yufitter_aggregater.rb | bundle exec ruby yufitter_generator.rb
```

- yufitter_aggregater
  - result.tsvをもとにTwitterからデータを取得する
- yufitter_generator
  - テンプレートを展開
 
