# README

# テーブル設計

##  usersテーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birthday           | date   | null: false|




##  sell-itemsテーブル

| Column                      | Type        | Options     |
| --------------------------- | ----------- | ----------- |
| item-name                   | string      | null: false |
| item-info                   | text        | null: false |
| item-category_id            | integer     | null: false |
| item-sales-status           | integer     | null: false |
| item-shipping-fee-status_id | integer     | null: false |
| item-prefecture_id          | integer     | null: false |
| item-scheduled-delivery_id  | integer     | null: false |
| item-price                  | integer     | null: false |
| user                        | references  | null: false, foreign_key: true |
| buy-sell                    | references  | null: false, foreign_key: true |

###  Association

-belongs_to :user
-has_one    :buy-item

##  buy-itemsテーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| postal-code        | integer       | null: false |
| prefecture         | integer       | null: false |
| city               | string        | null: false |
| addresses          | string        | null: false |
| building           | string        | null: false |
| phone-number       | string        | null: false | 


##  buy-item-dateテーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user               | references | null: false, foreign_key: true |
| sell-item          | references | null: false, foreign_key: true |

###  Association

-belongs_to :user
-belongs :sell-item

