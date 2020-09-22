# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class ContactMailer < ApplicationMailer
  default to: ENV['SENDER_EMAIL'] || 'yosis'

  def feedback()
    @contact = Contact.new(params[:contact_params])

    mail(subject: t('contact_mailer.contacted'),
         reply_to: @contact.sender_email || default_sender)
  end

  def default_sender
    ENV['SENDER_EMAIL'] || 'yosis'
  end
end
