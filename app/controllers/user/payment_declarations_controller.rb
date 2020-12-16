# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class User::PaymentDeclarationsController < ApplicationController
  before_action :authorize_user!

  def create
    AdminMailer.user_has_paid(current_user).deliver_later
    raise 'tbi'
  end
end

