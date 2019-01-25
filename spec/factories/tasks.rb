FactoryBot.define do
	factory :task do
		title {Faker::Lorem.sentence}
		description {Faker::Lorem.paragraph}
		start_date {Faker::Date.between(Date.today, 1.day.from_now)}
		end_date {Faker::Date.between(2.day.from_now, 3.day.from_now)}
		elapsed_time {Faker::Date.forward(2)}
		project
	end
end