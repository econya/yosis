# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Admin::EmailsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  # GET /emails
  def index
    @mails = Ahoy::Message.all.order(sent_ad: :desc)
  end

  def show
    @mail = Ahoy::Message.find(params[:id])
  end
end
