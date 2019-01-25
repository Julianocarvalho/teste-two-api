require 'rails_helper'

RSpec.describe Project, type: :model do
	let(:project) {build(:project)}

	it {is_expected.to validate_presence_of(:name)}
	it {is_expected.to allow_value("testando testes").for(:name)}


end
