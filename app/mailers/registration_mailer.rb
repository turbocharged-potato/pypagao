# frozen_string_literal: true

class RegistrationMailer < ApplicationMailer
  default from: %("Pypagao" <noreply@#{ENV['MAILGUN_DOMAIN']}>)

  def registration(user)
    @user = user
    @confirmation_link = "#{ENV['FRONTEND_VERIFY_URL']}?token=#{user.token}"
    mail(to: user.email, subject: 'Confirm your registration')
  end
end
