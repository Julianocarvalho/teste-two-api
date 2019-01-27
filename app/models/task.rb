class Task < ApplicationRecord
	belongs_to :project
	after_create :update_elapsed_time
	after_update :update_elapsed_time 
	validates :project_id, :title, presence: true


	def update_elapsed_time
		if self.started_date_changed? || self.elapsed_time == 0.0
			
		binding.pry
		task = Task.find(self.id)
		task.elapsed_time = ((closed_date - started_date) / 60 /60).to_i
		task.save
	end
	end
end
