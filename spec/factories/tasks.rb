FactoryBot.define do
  factory :task do
    title { Faker::Lorem.sentence }
    status { 'pending' }
    url { Faker::Internet.url }
  end
end
