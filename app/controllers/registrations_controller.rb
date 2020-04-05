# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class RegistrationsController < Devise::RegistrationsController
  invisible_captcha only: [:create], honeypot: :usernote

  def create
    super
    if @user.persisted?
      AdminMailer.new_registration(@user).deliver_later
    end
  end
end
