# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class NotifyEndingSubscriptionUsersJob < CronJob
  self.cron_expression= '5 7 * * *'

  def perform(*args)
    Subscription.where(date_end: (DateTime.current + 5.days).all_day).each do |subscription|
      SubscriptionReminderMailer.subscription_ends_soon(subscription.user).deliver_later
    end
  end
end

