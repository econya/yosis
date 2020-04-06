# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class NotifyEndingTrialUsersJob < CronJob
  self.cron_expression= '0 7 * * *'

  def perform(*args)
    User.trial_started_at(day: Date.current - 5.days).find_each do |user|
      SubscriptionReminderMailer.trial_ends_soon(user).deliver_later
    end
  end
end
