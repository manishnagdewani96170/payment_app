FactoryBot.define do
  factory :admin do
    name { 'John' }
    email { 'john_admin@gmail.com' }
    status { 'active' }
  end
end
