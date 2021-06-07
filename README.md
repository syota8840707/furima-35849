# README

# テーブル設計

##  usersテーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| name               | string | null: false |
| name_reading       | string | null: false |
| birthday           | day    | null: false|

##  sell-itemsテーブル

| Column                   | Type        | Options     |
| ------------------------ | ----------- | ----------- |
| item-name                | string      | null: false |
| item-info                | text        | null: false |
| item-category            | integer     | null: false |
| item-sales-status        | integer     | null: false |
| item-shipping-fee-status | integer     | null: false |
| item-prefecture          | integer     | null: false |
| item-scheduled-delivery  | integer     | null: false |
| item-price               | integer     | null: false |
| user                     | references  | null: false, foreign_key: true |
| buy-sell                 | references  | null: false, foreign_key: true |

###  Association

-belongs_to :user
-has_one    :buy-item

##  buy-itemsテーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| card-number        | integer       | null: false |
| card-exp-month     | integer       | null: false |
| card-exp-year      | integer       | null: false |
| card-cvc           | integer       | null: false |
| postal-code        | integer       | null: false |
| prefecture         | integer       | null: false |
| city               | string        | null: false |
| addresses          | string        | null: false |
| building           | string        |              |
| phone-number       | string        | null: false | 
| user               | references    | null: false, foreign_key: true |
| sell-item          | references    | null: false, foreign_key: true |

###  Association

-belongs_to :user
-belongs_to :sell-item

