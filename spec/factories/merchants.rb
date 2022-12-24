FactoryBot.define do
  factory :merchant do
    name { Faker::Internet.user_name }
    description  { Faker::Lorem.words(number: rand(2..10)).join(' ') }
    email { "#{name}@gmail.com" }
    status { 'active' }
    total_transaction_sum { 0.0 }
  end
end
