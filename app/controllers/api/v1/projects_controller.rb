class Api::V1::ProjectsController < ApplicationController
	respond_to :json


	def index

			project = Project.all
			render json: project
	end

	def show
		begin
			@project = Project.find(params[:id])
			respond_with @project
		rescue
			head 404
		end
	end

	def create
		project = Project.new(project_params)
		if project.save
			render json: project, status: 201
		else
			render json: { errors: project.errors }, status: 422
		end

	end

	def update
		project = Project.find(params[:id])
		if project.update(project_params)
			render json: project, status: 200
		else
			render json: { errors: project.errors }, status: 422
		end
	end
	
	def destroy
		project = Project.find(params[:id])
		project.destroy
		head 204
	end
	
	private
	def project_params
		params.require(:project).permit(:name, :description)
	end
end