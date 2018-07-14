# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  it 'is successful' do
    university = create(:university)
    user = create(:user, university: university)
    course = create(:course, university: university)

    sign_in(user)

    get :index, params: { code: course.code }
    should respond_with :ok
    expect(JSON.parse(response.body))
      .to eql({
        id: course.id,
        code: course.code,
        university_id: course.university_id
      }.with_indifferent_access)
  end
end
