FactoryBot.define do
  factory :task do
    title { "" }
    description { "MyText" }
    started_date { "2019-01-25 18:46:36" }
    closed_date { "2019-01-25 18:46:36" }
    elapsed_time { 1.5 }
    project { nil }
  end
end
