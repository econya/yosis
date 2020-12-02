# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class RegistrationsController < Devise::RegistrationsController
  invisible_captcha only: [:create], honeypot: :usernote
  layout 'devise_wide', only: [:create, :new]

  def create
    super
    if @user.persisted?
      AdminMailer.new_registration(@user).deliver_later
    end
  end

  protected

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :tos_agreement, :read_privacy_terms)
  end
end
