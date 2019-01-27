class Project < ApplicationRecord
	validates :name, presence: true
	has_many :tasks, dependent: :destroy

#	def self.elapsed_time_total(project_id)
#		binding.pry
#		project = Project.find(project_id)
#		project.tasks.pluck(:elapsed_time).sum
#
#	end
	#def elapsed_time_total(teste)
	#	"aula#{}"
	#end
end
