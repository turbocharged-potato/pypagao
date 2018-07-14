# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  before do
    @request.env['HTTP_ACCEPT'] = 'application/json'
    @request.env['CONTENT_TYPE'] = 'application/json'
  end

  describe 'GET #index' do
    it 'should return all courses' do
      courses = create_list(:course, 3)
      expected = courses.map do |c|
        { 'id' => c.id, 'code' => c.code, 'university_id' => c.university_id }
      end
      get :index
      should respond_with :ok
      expect(JSON.parse(response.body)).to eql(expected)
    end
  end
  describe 'POST #index' do
    it 'should save valid given information' do
      course = build(:course)
      post :create, params: { code: course.code,
                              university_id: course.university_id }
      should respond_with :ok
      expect(response.body).to eql('')
    end

    it 'sends 500 when error saving' do
      course = build(:course)
      allow(Course).to receive(:create).and_return(false)
      post :create, params: { code: course.code,
                              university_id: course.university_id }
      should respond_with :internal_server_error
      expect(response.body).to eql({ Error: 'Error saving' }.to_json)
    end
  end
end
