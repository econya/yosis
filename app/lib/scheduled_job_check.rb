# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class ScheduledJobCheck
  def self.all_cron_job_classes
    glob = Rails.root.join('app', 'jobs', '**', '*_job.rb')
    Dir.glob(glob).each {|f| require f}
    CronJob.subclasses
  end

  def self.all_scheduled?
    all_cron_job_classes.all? { |job| job.scheduled? }
  end

  def self.schedule_all!
    Rails.logger.info 'Scheduling all cronish jobs'
    all_cron_job_classes.each { |job| job.schedule }
  end
end
