# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PapersController, type: :controller do
  before do
    @user_university = create(:university)
    @user = create(:user, university: @user_university)
    code = 'CS1101S'
    @course = create(:course, code: code, university: @user_university)
    @semester = create(:semester,
                       course: @course)
  end

  describe '#GET index' do
    before do
      sign_in(@user)
    end

    it 'should list paper by semester' do
      paper = create(:paper, semester: @semester)
      get :index, params: { semester_id: @semester.id }
      should respond_with :ok
      expect(JSON.parse(response.body))
        .to eql([paper_hash(paper).with_indifferent_access])
    end

    it 'should not list semesters with different semester id' do
      semester = create(:semester, course: @course)
      get :index, params: { semester_id: semester.id }
      should respond_with :ok
      expect(JSON.parse(response.body)).to eql([])
    end

    it 'should not list courses from different university' do
      non_user_university = create(:university)
      course = create(:course, university_id: non_user_university.id)
      semester = create(:semester, course_id: course.id)
      get :index, params: { semester_id: semester.id }
      should respond_with :ok
      expect(JSON.parse(response.body)).to eql([])
    end
  end

  describe 'GET #index if signed out' do
    it 'should not list any courses if signed out' do
      get :index
      should respond_with :unauthorized
    end
  end

  describe 'GET #show' do
    before do
      sign_in(@user)
    end

    it 'should show you paper' do
      paper = create(:paper, semester: @semester)
      get :show, params: { id: paper.id }
      ans = paper_hash(paper).slice(:id, :name, :semester_id)
      expect(response.body).to eql(ans.to_json)
      should respond_with :ok
    end
  end

  describe 'POST #create' do
    before do
      sign_in(@user)
    end

    it 'should save given valid information' do
      paper = build(:paper, semester: @semester)
      post :create, params: paper_hash(paper)
      should respond_with :ok
      expect(response.body).to eq('')
    end

    it 'should not save information when university does not match' do
      university = create(:university)
      course = create(:course, university: university)
      semester = create(:semester, course: course)
      paper = build(:paper, semester_id: semester.id)
      post :create, params: paper_hash(paper)
      should respond_with :bad_request
      expect(response.body)
        .to eq({ error: 'University does not match current user' }.to_json)
    end

    it 'sends 400 when error saving' do
      paper = build(:paper, semester: @semester)
      allow_any_instance_of(Paper).to receive(:save).and_return(false)
      post :create, params: paper_hash(paper)
      should respond_with :bad_request
    end
  end

  private

  def paper_hash(paper)
    { id: paper.id,
      semester_id: paper.semester_id,
      name: paper.name}
  end
end
