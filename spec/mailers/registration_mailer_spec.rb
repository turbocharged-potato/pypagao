# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RegistrationMailer, type: :mailer do
  describe '#registration' do
    let(:mail) do
      @user = create(:user)
      RegistrationMailer.registration(@user)
    end

    it 'renders the header' do
      expect(mail.subject).to eq('Confirm your registration')
      expect(mail.to).to eq([@user.email])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(@user.token)
    end
  end
end
