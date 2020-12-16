# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class User::PaymentDeclarationsController < ApplicationController
  before_action :authorize_user!

  def create
    raise 'tbi'
  end
end

