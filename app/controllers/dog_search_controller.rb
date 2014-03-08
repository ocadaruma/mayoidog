# coding: utf-8
require "twitter"

class DogSearchController < ApplicationController

  def index
    
    # アプリケーションキー(consumer key/secret)の読み込み
    Twitter.configure do |cnf|
      cnf.consumer_key = "wPF0o8LE4ow68SeePse4Q"
      cnf.consumer_secret = "zFNV7mlbPRXTMOYSOIV9Y7bJaumVW0PtbYfYugqpPc"
    end

    # OAuth アクセストークンの読み込み
    @client = Twitter::Client.new(
      :oauth_token => "191064360-8WEJwdhrClgUKfDCFJRxzHbDUvbrttEbqz6c6IRK",
      :oauth_token_secret => "7wyxc71ZXJY2dhG7jkZMfZm8x6212HXwVGsls6QsevPSr"
    )
  
    # 変数の初期化
    since_id = 0
    counter = 0
    
    @tweets = Array.new
    
    begin
      # 引数で受け取ったワードを元に、検索結果を取得し、古いものから順に並び替え
      # ※最初はsince_id=0であるため、tweet ID 0以降のTweetから最新のもの上位100件を取得
      @client.search("迷い犬", :count => 100, :result_type => "recent", :since_id => since_id).results.reverse.map do |status|

      # Tweet ID, ユーザ名、Tweet本文、投稿日を1件づつ表示
      #{status.id} :#{status.from_user}: #{status.text} : #{status.created_at}

      tweet = Tweet.new
      tweet.user = status.from_user
      tweet.tweet = status.text
      
      @tweets.push(tweet)
      
      # 取得したTweet idをsince_idに格納
      # ※古いものから新しい順(Tweet IDの昇順)に表示されるため、
      #  最終的に、取得した結果の内の最新のTweet IDが格納され、
      #  次はこのID以降のTweetが取得される
      since_id=status.id
    end

      # 検索ワードで Tweet を取得できなかった場合の例外処理
    rescue Twitter::Error::ClientError
      # 60秒待機し、リトライ
      sleep(60)
    retry
    end
  
  end


end
