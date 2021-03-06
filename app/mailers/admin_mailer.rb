# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class AdminMailer < ApplicationMailer
  default to: ENV['SENDER_EMAIL'] || 'yosis'

  def new_registration(user)
    @user = user#params[:user]

    mail(subject: t('admin_mailer.new_registration.subject'))
  end

  def new_confirmation(user)
    @user = user#params[:user]

    mail(subject: t('admin_mailer.new_confirmation.subject'))
  end

  def invitation_accepted(user)
    @user = user
    mail(subject: t('admin_mailer.invitation_accepted.subject'))
  end

  def user_has_paid(user)
    @user = user
    mail(subject: t('admin_mailer.user_has_paid.subject'))
  end
end
