# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class AccessState
  STATES = [:none,
            :unconfirmed, :invitation_pending,
            :trial, :trial_ended,
            :subscribed, :subscription_ended,
            :admin]
  LEVELS = [:none, :trial, :full, :admin]
  LEVEL_BY_STATE = {
    none:               :none,
    unconfirmed:        :none,
    invitation_pending: :none,
    trial:              :trial,
    trial_ended:        :none,
    subscribed:         :full,
    subscription_ended: :none,
    admin:              :admin
  }

  def initialize user
    @user = user
  end

  def state
    return :none if @user.nil?

    return :admin if @user.admin?

    return :unconfirmed if @user.confirmed_at.nil?
    return :invitation_pending if @user.invitation_token

    return :trial if @user.in_trial_period?
    return :trial_ended if !@user.in_trial_period? && @user.subscriptions.empty?

    return :subscribed if @user.currently_subscribed?
    return :subscription_ended
  end

  def level
    LEVEL_BY_STATE[state]
  end
end
