require 'rails_helper'

RSpec.describe Api::V1::TasksController do
  let!(:project) { create(:project)}  
  let(:project_id) { project.id }
  let(:headers) do
    {
      'Content-Type' => Mime[:json].to_s,
      'Accept' => 'application/vnd.teste-two.v1'
    }
  end

  before{ host! 'api.teste-two.test'}


  describe 'GET /tasks' do
    let!(:task) {create(:task, project_id: project_id)}

    before { get "/tasks", params: {}, headers: headers}

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns the json for task' do
      expect(json_body).to be_truthy
    end

  end

  describe 'GET /tasks/:id' do
    let(:task) {create(:task, project_id: project_id)}

    before { get "/tasks/#{task.id}", params: {}, headers: headers}

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns the json for task' do
      expect(json_body[:title]).to eq(task.title)
    end 
  end

end