# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Admin::DelayedJobs::ExecutionController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def create
    @job = Delayed::Job.find(params[:delayed_job_id])
    @job.update(run_at: DateTime.current)

    redirect_to admin_delayed_jobs_url,
      notice: t('admin.delayed_job.execution.triggered')
  end
end

