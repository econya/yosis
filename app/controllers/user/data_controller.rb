# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class User::DataController < ApplicationController
  before_action :authorize_user!

  def show
    render plain: {
      id: current_user.id,
      email: current_user.email,
      reset_password_sent_at: current_user.reset_password_sent_at.to_s,
      sign_in_count: current_user.sign_in_count,
      current_sign_in_at: current_user.current_sign_in_at.to_s,
      current_sign_in_ip: current_user.current_sign_in_ip,
      last_sign_in_at: current_user.last_sign_in_at.to_s,
      last_sign_in_ip: current_user.last_sign_in_ip,
      confirmed_at: current_user.confirmed_at.to_s,
      confirmation_sent_at: current_user.confirmation_sent_at.to_s,
      created_at: current_user.created_at.to_s,
      updated_at: current_user.updated_at.to_s,
      invitation_accepted_at: current_user.invitation_accepted_at.to_s,
      terms_accepted_at: current_user.terms_accepted_at.to_s,

      # subscriptions
      # ahoy_messages/mails
    }.to_yaml
  end

  def destroy
    # anonymization
    raise NotImplementedError
  end
end

