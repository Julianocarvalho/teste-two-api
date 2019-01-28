class Task < ApplicationRecord
	belongs_to :project
	after_create :calc_elapsed_time
	after_update :update_elapsed_time 
	validates :project_id, :title, :started_date, :closed_date, presence: true

	def update_elapsed_time
		if self.started_date_changed?
			task = Task.find(self.id)
			task.elapsed_time = task.elapsed_time + ((closed_date - started_date) / 60 /60).to_i
			task.save
		end
	end

	def calc_elapsed_time
		task = Task.find(self.id)
		task.elapsed_time = task.elapsed_time + ((closed_date - started_date) / 60 /60).to_i
		task.save
	end

end
