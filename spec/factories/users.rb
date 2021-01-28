FactoryBot.define do
  factory :user, class: User do
    last_name {'山田'}
    first_name { '太郎' }
    last_name_kana { 'ヤマダ' }
    first_name_kana { 'タロウ' }
    sequence(:email) { 'yamada@example.com'}
    address { '東京都1-1-1' }
    zipcode { '6666666'}
    phone_number { '0909999999'}
    is_deleted { false }
    introduction { '初めまして' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
