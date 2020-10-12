# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

namespace :db do
  desc 'Schedule all cron jobs'
  task schedule_jobs: :environment do
    ScheduledJobCheck.schedule_all!
  end
end

# invoke schedule_jobs automatically after every migration and schema load.
%w(db:migrate db:schema:load).each do |task|
  Rake::Task[task].enhance do
    Rake::Task['db:schedule_jobs'].invoke
  end
end
