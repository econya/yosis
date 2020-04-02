# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Admin::EmailsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  # GET /emails
  def index
    @pagy, @mails = pagy(
      Ahoy::Message.all.order(sent_at: :desc), items: 20)
  end

  def show
    @mail = Ahoy::Message.find(params[:id])
  end
end
