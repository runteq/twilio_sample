# README
* 告白サービスのサンプル

## Ruby version
* 2.7.2

## Rails version  
* See Gemfile.

## Project initiation  
* リポジトリのclone  

```
git clone git@github.com:runteq/twilio_sample.git
```

## Twilio設定
* config/master.keyおよびconfig/credentials.yml.encはignoreしているのでご自身で作成ください

```
EDITOR=vim bin/rails credentials:edit
```

* 以下の形でtwilioのアカウントSID、トークン、発信番号を設定してください
```
twilio:
  sid: xxxxxxxxxxxxxxxxxxxxxxxx
  token: xxxxxxxxxxxxxxxxxxxxxxxx
  phone_number: +11112222
```

## ngrokの設定

* config/environments/development.rb
```
Rails.application.routes.default_url_options[:host] = '' # ngrokのホストを設定してください
```

## Railsの起動

* 起動コマンド

```
bin/rails s
```

## Webpack-dev-serverの起動(JS、CSSのコンパイル)

* 起動コマンド

```
bin/webpack-dev-server
````

