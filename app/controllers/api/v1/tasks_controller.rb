class Api::V1::TasksController < ApplicationController
	respond_to :json


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

	def update
		task = Task.find(params[:id])
		if task.update(task_params)
			task.reload
			render json: task, status: 200
		else
			render json: { errors: task.errors }, status: 422
		end
	end

	def destroy
		task = Task.find(params[:id])
		task.destroy
		head 204
	end

	private
	def task_params
		params.require(:task).permit(:title, :description, :project_id, :started_date, :closed_date)
	end
end
