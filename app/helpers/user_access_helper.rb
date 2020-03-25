# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

module UserAccessHelper
  def user_has_access?
    user_signed_in? && (current_user.role == 'admin' || current_user&.in_trial_period? || current_user.currently_subscribed?)
  end

  def user_has_limited_access?
    user_signed_in? && current_user.in_trial_period?
  end

  def days_till_end_of_subscription user
    return nil if user.admin?

    current_subscription = user.subscriptions.where("date_start <= ? AND date_end >= ?", DateTime.current, DateTime.current).first

    return nil if current_subscription.nil?

    (current_subscription.date_end.to_date - Date.current).to_i
  end

  def days_till_end_of_trial user
    return nil if !user.in_trial_period?
    return nil if user.admin?

    7 - (Date.current - user.confirmed_at.to_date).to_i
  end
end

