# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class User::PaymentDeclarationsController < ApplicationController
  before_action :authorize_user!

  def create
    if current_user.mark_paid_at
      redirect_to root_path, error: t('user.payment_declaration.rejected')
    end

    AdminMailer.user_has_paid(current_user).deliver_later
    current_user.update(mark_paid_at: DateTime.current)

    if current_user.currently_subscribed?
      current_subscription = current_user.subscriptions.current.first
      current_subscription.update(date_end: current_subscription.date_end + 2.days,
                                  notes: current_subscription.notes + "\n(temporarily extended)")
    else
      current_user.subscriptions.create(date_start: DateTime.current,
                                        date_end: DateTime.current + 2.days,
                                        notes: t('user.payment_declaration.temporary_subscription'))
    end
    #  subscribed -> prolong subscription
    # if user not -> create a two day subscription

    redirect_to root_path, notice: t('user.payment_declaration.received')
  end
end

