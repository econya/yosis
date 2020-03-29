# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class RegistrationsController < Devise::RegistrationsController
  def create
    super
    if @user.persisted?
      AdminMailer.new_registration(@user).deliver#later?
    end
  end
end
