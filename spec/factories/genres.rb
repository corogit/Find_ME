FactoryBot.define do
  factory :genre do
    sequence(:name) { |n| "ジャンル_#{n}" }
    is_active       { true }
  end
end
