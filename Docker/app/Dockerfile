FROM ruby:2.5.7

# 必要なライブラリをインストール
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# ルートディレクトリを設定
RUN mkdir /myapp
WORKDIR /myapp

# Gemfileを設定・インストール
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp

# コンテナー起動時に毎回実行されるスクリプトを追加
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

RUN mkdir -p tmp/sockets