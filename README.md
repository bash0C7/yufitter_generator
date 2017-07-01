# yufitter_generator

## Setup

- save result.tsv to project root
 - 事前に改行を|に変換
- save ads.txt to project root
 - 広告の"itemSource"HTMLスニペットを1行1アイテムで保存
- create .env

```
TWITTER_CONSUMER_KEY=xxxxxxxxxxxxxxxxxx
TWITTER_CONSUMER_SECRET=xxxxxxxxxxxxxxxxxx
TWITTER_ACCESS_TOKEN=xxxxxxxxxxxxxxxxxx
TWITTER_ACCESS_TOKEN_SECRET=xxxxxxxxxxxxxxxxxx
```

## Run

```sh
bundle exec ruby yufitter_aggregater.rb | bundle exec ruby yufitter_generator.rb
```

- yufitter_aggregater
 - result.tsvをもとにTwitterからデータを取得する
- yufitter_generator
 - テンプレートを展開
 