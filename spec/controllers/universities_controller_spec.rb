# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UniversitiesController, type: :controller do
  describe 'GET #index' do
    it 'should return all universities' do
      universities = create_list(:university, 3)
      expected = universities.map do |u|
        { 'id' => u.id, 'name' => u.name, 'domain' => u.domain }
      end
      get :index
      should respond_with :ok
      expect(JSON.parse(response.body)).to eql(expected)
    end
  end

  describe 'POST #create' do
    it 'should save given valid information' do
      university = build(:university)
      post :create, params: { name: university.name, domain: university.domain }
      should respond_with :ok
      expect(response.body).to eq('')
    end

    it 'sends 500 when error saving' do
      university = build(:university)
      allow(University).to receive(:create).and_return(false)
      post :create, params: { name: university.name, domain: university.domain }
      should respond_with :internal_server_error
      expect(response.body).to eq({ error: 'Error saving' }.to_json)
    end
  end

  describe 'GET #show' do
    it 'should return the correct university info' do
      universities = create_list(:university, 3)
      universities.map do |u|
        expected = { 'id' => u.id, 'name' => u.name, 'domain' => u.domain }
        get :show, params: { id: u.id }
        should respond_with :ok
        expect(JSON.parse(response.body)).to eql(expected)
      end
    end
  end
end
