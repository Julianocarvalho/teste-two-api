require 'rails_helper'

RSpec.describe Api::V1::TasksController do
  let(:headers) do
    {
      'Content-Type' => Mime[:json].to_s,
      'Accept' => 'application/vnd.teste-two.v1'
    }
  end

  before{ host! 'api.teste-two.test'}

  describe 'GET /tasks/:id' do
    
    let(:task) {create(:task)}

    before { get "/tasks/#{task.id}", params: {}, headers: headers}

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns the json for task' do
      expect(json_body[:title]).to eq(task.title)
    end 
  end

  describe 'POST /tasks' do
    let!(:task) {create(:task)}

    context 'when the params are valid' do
      let!(:task_params) {build(:task).attributes}
      
      before do 
        post '/tasks', params: {task: task_params}.to_json, headers: headers
      end

      it 'returns status code 201'do
        expect(response).to have_http_status(201)
      end

      it 'saves the task in the database' do
        expect(Task.find_by(title: task_params['title'])).not_to be_nil
     end

      it 'reuturns the json for created task' do

        expect(json_body[:title]).to eq(task_params['title'])
      end
  end
end

end