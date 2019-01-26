class Api::V1::TasksController < ApplicationController
	respond_to :json

	def index

			task = Task.all
			render json: task
	end

	def show
		begin
			task = Task.find(params[:id])
			render json: task
		rescue
			head 404
		end
	end

	def create
		task = Task.new(task_params)

		if task.save
			render json: task, status: 201
		else
			render json: { errors: task.errors }, status: 422
		end

	end

	def tasks_by_project_id
		tasks_by_project = Task.where(project_id: params[:project_id])

		respond_with tasks_by_project
	end

	private
	def task_params
		params.require(:task).permit(:title, :description)
	end
end
