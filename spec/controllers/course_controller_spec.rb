# frozen_string_literal: true

require 'rails_helper'

Rspec.describe CourseController, type: :controller do


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
      course = build(:course) do
      post :create, params: { code: course.name,
                              university_id: course.university_id }
      should respond_with :ok
      expect(response.body).to eql('')
    end

    it 'sends 500 when error saving' do
      course = build(:course)
      
    end

  end
end