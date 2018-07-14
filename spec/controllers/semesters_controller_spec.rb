# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SemestersController, type: :controller do
  before do
    @request.env['HTTP_ACCEPT'] = 'application/json'
    @request.env['CONTENT_TYPE'] = 'application/json'
  end

  describe 'GET #show' do
  end
  describe 'POST #create' do
    it 'should save valid given information' do
      semester = build(:semester)
      post :create, params: { course_id: semester.course_id,
                              end_year: semester.end_year,
                              start_year: semester.start_year,
                              number: semester.number }
      should respond_with :ok
      expect(response.body).to eql('')
    end

    it 'should send 500 when error saving' do
      semester = build(:semester)
      allow(Semester).to receive(:create).and_return(false)
      post :create, params: { course_id: semester.course_id,
                              end_year: semester.end_year,
                              start_year: semester.start_year,
                              number: semester.number }
      should respond_with :internal_server_error
      expect(response.body).to eql({ error: 'Error saving' }.to_json)
    end
  end
end
