# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Admin::DelayedJobsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    @jobs = Delayed::Job.all
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @job = Delayed::Job.find params[:id]
    @job.destroy
    redirect_to admin_delayed_jobs_url, notice: t('admin.delayed_job.deleted')
  end
end

