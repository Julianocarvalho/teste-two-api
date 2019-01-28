FactoryBot.define do
	factory :task do
		title {Faker::Lorem.sentence}
		description {Faker::Lorem.paragraph}
		started_date {Faker::Date.between(Date.today, 1.day.from_now)}
		closed_date {Faker::Date.between(2.day.from_now, 3.day.from_now)}
		project 
	end
end