# frozen_string_literal: true

class RegistrationMailer < ApplicationMailer
  default from: %("Pypagao" <noreply@#{ENV['MAILGUN_DOMAIN']}>)

  def registration(user, confirmation_link)
    @user = user
    @confirmation_link = confirmation_link
    mail(to: user.email, subject: 'Confirm your registration')
  end
end
