FactoryBot.define do
  factory :merchant do
    name { 'John' }
    description  { Faker::Lorem.words(number: rand(2..10)).join(' ') }
    email { 'john@gmail.com' }
    status { 'active' }
    total_transaction_sum { 0.0 }
  end
end
