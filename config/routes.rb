require 'api_version_constraint'
Rails.application.routes.draw do
 # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api , defaults: {format: :json}, constraints: {subdomain: 'api'}, path: "/" do
  	namespace :v1 , path: '/', constraints: ApiVersionConstraint.new(version: 1, default: true) do
  		resources :users, only: [:show, :create, :update, :destroy]
  		resources :projects, only: [:index, :show, :create, :update, :destroy] 
  		resources :tasks, only: [:show, :create, :update, :destroy]
  		match 'projects/:id/tasks' => 'projects#tasks_by_project', via: :get
  	end
  end

end
