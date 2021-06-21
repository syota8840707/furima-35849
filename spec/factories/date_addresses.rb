FactoryBot.define do
  factory :date_address do
    postal_code { '123-4567' }
    prefecture_id { 3 }
    city { '東京都' }
    address { '1-1' }
    bilding { '東京ハイツ' }
    phone_number { '07055856899' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
