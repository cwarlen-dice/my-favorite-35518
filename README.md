# README

## アプリ名

my-favorite-35518

## 概要

このアプリケーションは、登録ユーザーによる画像の投稿ができます。非登録の場合は、閲覧のみ可能です。
登録ユーザーは、承認画像設定を行うことができます。
承認画像設定を行うことで、メッセージ機能を有効化することができるようになります。相手にメッセージを送りたい場合、相手側も承認画像設定を完了させている必要があります。
初めての相手にメッセージを送る場合、相手の設定した承認画像を選択し、正しい画像を選択する必要があります。正しい画像が選択できなかった場合には、メッセージを送ることはできません。


![承認成功](https://user-images.githubusercontent.com/82791776/123754985-6e5bda80-d8f6-11eb-9218-8f1ec8f09217.gif)

![承認失敗](https://user-images.githubusercontent.com/82791776/123755315-bb3fb100-d8f6-11eb-8a2f-fdf6e615f423.gif)

## 本番環境

https://my-favorite-35518.herokuapp.com/

- ID:test
- Password:aaa111

- ID:test2
- Password:aaa111

## 制作背景

通常の投稿サイトでは、自分以外のユーザーの声を聞ける反面、過度な反応によるストレスにもなると感じました。
そのため、ユーザー同士のコミュニケーション機能をあえて最低限にして、できるだけストレスを感じない投稿サイトを作って見ようと思いました。

## 工夫したポイント

1. 画像承認機能の実装
   コミュニケーション手段に承認機能を設けました。
   この機能を設けることで、２つの効果を狙いました。
   1. 迷惑行為を低減させる
      メッセージを送るために手間が必要となるため
   2. 受け手側のストレスを緩和させる
      自分の好みを理解できたユーザーからのみメッセージを受け付けるため

2. 実装にあたってのポイント
   1. 正解の画像の表示位置をランダム表示させる。
   2. ダミー画像のidをランダムで採番して、他ユーザーと比較してダミーの特定を防止。

## 開発環境

- Rails 6.0.3.7
- ruby 2.6.5p114
- mysql 5.6.50
- heroku 7.54.1
- git version 2.30.1

## 課題や今後実装したい機能

現在の画像承認画面では、検証ツールを開くと、urlからダミーを判別できてしまう。
セキュリティの観点からurlでの判別をできない様にしたい。

いいね機能を実装を実装したい。

## DB設計

### usersテーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| email              | string  | default: ''               |
| encrypted_password | string  | null: false               |
| nickname           | string  | null: false, unique: true |
| birthday           | date    |                           |
| blood_type_id      | integer |                           |
| profile            | text    |                           |
| impressions_count  | integer | default: 0                |

#### Association

- has_one_attached :image
- has_many :items
- has_many :permit_images
- has_many :room_users
- has_many :rooms, through: :room_users
- has_many :messages

### itemsテーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| user              | references | null: false, foreign_key: true |
| name              | string     |                                |
| comment           | text       |                                |
| impressions_count | integer    | default: 0                     |

#### Association

- has_one_attached :image, dependent: :destroy
- belongs_to :user
- has_one :permit_image
- has_many :item_tag_mts, dependent: :destroy
- has_many :tags, through: :item_tag_mts
- has_one :item_genre_mt, dependent: :destroy
- has_one :genre, through: :item_genre_mt

### item_genre_mtsテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| item   | references | null: false, foreign_key: true |
| user   | references | null: false, foreign_key: true |
| genre  | references | null: false                    |


#### Association

- belongs_to :item
- belongs_to :tag

### tagsテーブル

| Column | Type   | Options                   |
| ------ | ------ | ------------------------- |
| name   | string | null: false, unique: true |

#### Association

- has_many :item_tag_mts, dependent: :destroy
- has_many :items, through: :item_tag_mts


### item_tag_mtsテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| item   | references | null: false, foreign_key: true |
| tag    | references | null: false, foreign_key: true |

#### Association

- belongs_to :item
- belongs_to :tag

### roomsテーブル

idのみ追加カラムなし

#### Association

- has_many :room_users, dependent: :destroy
- has_many :users, through: :room_users
- has_many :messages, dependent: :destroy

### room_usersテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| room   | references | null: false, foreign_key: true |

#### Association

- belongs_to :user
- belongs_to :room


### messagesテーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| content | string     |                                |
| user    | references | null: false, foreign_key: true |
| room    | references | null: false, foreign_key: true |

#### Association

- belongs_to :room
- belongs_to :user
- has_one_attached :image

### permit_imagesテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| item   | references | null: false, foreign_key: true |
| room   | references | null: false, foreign_key: true |

#### Association

- belongs_to :user
- belongs_to :item
