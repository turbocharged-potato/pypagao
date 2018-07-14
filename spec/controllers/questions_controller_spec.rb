# frozen_string_literal: true

require 'rails_helper'
RSpec.describe QuestionsController, type: :controller do
  before do
    @request.env['HTTP_ACCEPT'] = 'application/json'
    @request.env['CONTENT_TYPE'] = 'application/json'
  end

  describe 'POST#create' do
    it 'should save given valid information' do
      question = build(:question)
      post :create, params: { name: question.name,
                              paper_id: question.paper_id }
      should respond_with :ok
      expect(response.body).to eql('')
    end

    it 'should return 500 when error saving' do
      question = build(:question)
      allow(Question).to receive(:create).and_return(false)
      post :create, params: { name: question.name,
                              paper_id: question.paper_id }
      should respond_with :internal_server_error
      expect(response.body).to eql({ error: 'Error saving' }.to_json)
    end
  end
end
