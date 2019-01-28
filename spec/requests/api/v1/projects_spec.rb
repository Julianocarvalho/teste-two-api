require 'rails_helper'

RSpec.describe 'Projects API', type: :request do
  let!(:project) { create(:project) }
  let(:project_id) { project.id }
  let(:headers) do
    {
      'Accept' => 'application/vnd.teste-two.v1',
      'Content-Type' => Mime[:json].to_s
    }
  end

  before { host! "api.teste-two.test"}


  describe 'GET /projects' do
    let!(:project) {create(:project)}

    before { get "/projects", params: {}, headers: headers}

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns the json for projects' do
      expect(json_body).to be_truthy
    end

  end

  describe "GET /projects/:id" do
    before do
      get "/projects/#{project_id}", params: {}, headers: headers
    end

    context "when the project exists " do
      it "returns the project" do
        expect(json_body[:id]).to eq(project_id)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end

      context "when the project does not exists " do
        let(:project_id) { 30 }
        it "returns status code 404" do
          expect(response).to have_http_status(404)
        end
      end
    end

    describe 'POST /projects' do
      before do
        post '/projects', params: { project: project_params }.to_json, headers: headers
      end
      context 'when the request params are valid' do
        let(:project_params) { attributes_for(:project) }
        it 'returns status code 201' do
          expect(response).to have_http_status (201)
        end
        it 'returns json data for the create project ' do
          expect(json_body[:name]).to eq(project_params[:name])
        end
      end

      context 'when the request params are invalid' do
        let(:project_params) {attributes_for(:project, name: nil)}
        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end
        it 'returns the json data for the erros' do
          expect(json_body).to have_key(:errors)
        end
      end
    end

    describe 'PUT /projects/:id' do
      before do
        put "/projects/#{project_id}", params: { project: project_params }.to_json, headers: headers
      end
      context 'when the request params are valid' do
        let(:project_params) {{name: "Testando teste"}}

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
        it 'returns the json data for the update project ' do

          expect(json_body[:name]).to eq(project_params[:name])

        end
      end
      context 'when the request params are invalid' do
        let(:project_params) {attributes_for(:project, name: nil)}

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end
        it 'returns the json data for the erros' do
          expect(json_body).to have_key(:errors)
        end
      end
    end

    
    describe 'DELETE /projects/:id' do
      before do
        delete "/projects/#{project_id}", params: {}, headers: headers
      end
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
      it 'removes the project from database' do
        expect(Project.find_by(id: project.id)).to be_nil
      end
    end
  end
end