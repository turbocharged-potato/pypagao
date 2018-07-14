# frozen_string_literal: true

RSpec.describe PapersController, type: :controller do
  before do
    @request.env['HTTP_ACCEPT'] = 'application/json'
    @request.env['CONTENT_TYPE'] = 'application/json'
  end

  describe 'POST#create' do
    it 'should save given valid information' do
      paper = build(:paper)
      post :create, params: { name: paper.name,
                              semester_id: paper.semester_id }
      should respond_with :ok
      expect(response.body).to eql('')
    end

    it 'should return 500 when error saving' do
      paper = build(:paper)
      allow(Paper).to receive(create).and_return(false)
      post :create, params: { name: paper.name,
                              semester_id: paper.semester_id }
      should respond_with :internal_server_error
      expect(response.body).to eql({ error: 'Error saving' }.to_json)
    end
  end
end
