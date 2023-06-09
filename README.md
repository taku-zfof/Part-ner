# Part-ner

## サイト概要
### サイトテーマ
バイトは「誰と」で選びたい。バイトを探しを通じて人と人とをつなげるマッチングサービス。


### テーマを選んだ理由
自分がこれまで単発のアルバイトや単調な作業アルバイトなどを経験する中で、「友達がいたらもっと働きやすいのに」「誰かと一緒なら応募したいのに」といった事を考える機会が多くありました。<br>
基本的にバイト探しは条件や仕事内容を見て企業に応募するもので、働く仲間は後から見つけるものでした。仕事内容だけでなく、一緒に働く人も選べるプラットフォームがあればよかったのに、という思いからテーマを設定しました。

### 基本的な使い方
* 【応募ユーザー】アルバイトを探せる。企業に応募するのではなく、募集をしているのは将来のバイト仲間。
* 【募集ユーザー】バイトの詳細を投稿することで、自分のバイト先に紹介する仲間を探せる。
* 応募ユーザーは投稿されたバイト情報と募集ユーザーを見て、気に入った場合は募集ユーザーに対してチャットのオファーを送る。
* 募集ユーザーはチャットを通じて気に入った場合、応募ユーザーをバイト仲間として紹介できる。

### ターゲットユーザー
* バイト探しに、人間関係面の不安がある人
* バイトを探しているものの、応募に踏み切れない人
* 自分のバイト先でバイト仲間を作りたい人

### 主な利用シーン
* バイトを探すとき
* バイト仲間が欲しいとき
* バイト先へ友達紹介をしたいとき

## 開発環境
- Docker/Docker-compose
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails, MDBootstrap5
- JSライブラリ：jQuery
- IDE：Cloud9

## テスト
- RSpec
- Github Actionsによる自動テスト

## 本番環境
- AWS (EC2,RDS)
- MySQL2
- Nginx、 Puma
- Github Actionsによる自動デプロイ

## 使用技術
- ユーザー認証機能、ゲストログイン機能（devise）
- SNS認証機能（Google、Twitterでのログイン）
- 画像アップロード機能（Active Storage）
- 投稿のSNSシェア機能（Twitterで共有）
- 投稿の下書き機能
- 投稿と自己紹介文に「あと〇〇文字」の表示
- 住所の自動入力機能
- 画像プレビュー機能（jQuery）
- 無限スクロール機能（jQuery）
- 投稿の絞込み検索機能
- 募集に対するオファー（DMリクエスト）機能
- リアルタイムチャット（Action Cable）
- 通知機能（オファーとDMそれぞれ）
- 非同期通信（Ajax。オファーとブックマークに採用）
- タブメニュー、モーダル、ツールチップ等MDBootstrapコンポーネントの活用
- Google Maps API、Geocoding API
- Heartrails API（駅・路線情報の使用）
- Action Mailer
- 定時処理（未読通知ある場合にメール送信）
- 例外処理（エラー画面に遷移させずフラッシュメッセージを表示）
- Docker環境構築
- Https化
- slim記法

## 使用素材
- フォント：せのびゴシック（http://modi.jpn.org/font_senobi.php）
- ロゴ・favicon素材作成：Canva（https://www.canva.com/）
- favicon作成：Favicon ジェネレーター（https://favicon-generator.mintsu-dev.com/）
- サンプルデータ素材：photoAC（https://www.photo-ac.com/）
- noimage素材、aboutページなどのイラスト素材：unDraw（https://undraw.co/）

## 設計書等
- 実装機能リスト : (https://docs.google.com/spreadsheets/d/1KvpgtNfRZIdZXWGXveWcdHxIT_q6luyyW-vhdPpbdCM/edit?usp=sharing)
- WBS : (https://docs.google.com/spreadsheets/d/1eEqrMuWoFfGu6LeMgfXPfS9cMUMM3Wa0fLnLIztlMdA/edit?usp=sharing)
- テーブル定義書 : (https://docs.google.com/spreadsheets/d/1LIUpZH5LBCQhBmSAWwTvdN8QQmk87YJMJWTP8BqHtIQ/edit?usp=sharing)
- ER図 : (https://drive.google.com/file/d/1SNTUzvYsYRI6xK1Fc9BJyTy5gO9ONAqu/view?usp=sharing)
- ワイヤーフレーム : (https://drive.google.com/file/d/1MK9j6DTC2_FPx_QWRob_Y3e5mV4mhkTu/view?usp=sharing)
