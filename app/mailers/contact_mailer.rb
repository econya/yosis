# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class ContactMailer < ApplicationMailer
  default to: ENV['SENDER_EMAIL'] || 'yosis'

  def feedback()
    @user    = params[:user]
    @contact = Contact.new(subject: params[:subject],
                           message: params[:message])

    mail(subject: t('contact_mailer.contacted'), reply_to: @user.email)
  end
end
