# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class NotifyEndingTrialUsersJob < CronJob
  self.cron_expression= '0 7 * * *'

  def perform(*args)
  end
end
