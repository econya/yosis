# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class ConfirmationsController < Devise::ConfirmationsController
  def show
    super
    if resource.errors.empty?
      AdminMailer.new_confirmation(@user).deliver #later
    end
  end
end
