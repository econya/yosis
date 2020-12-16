# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class SubscriptionReminderMailer < ApplicationMailer
  default to: ENV['SENDER_EMAIL'] || 'yosis'

  def subscription_ends_soon(user)
    @user = user#params[:user]

    mail(to: user.email,
         subject: prepend_title(
           t('subscription_reminder_mailer.subscription_ends_soon.subject'))
        )
  end

  def trial_ends_soon(user)
    @user = user#params[:user]

    mail(to: user.email,
         subject: prepend_title(
           t('subscription_reminder_mailer.trial_ends_soon.subject'))
        )
  end

  private

  def prepend_title string
    "%s: %s" % [SiteSettings.fetch('title').value, string]
  end

end
