# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :confirmable, :recoverable, :rememberable, :validatable,
         :trackable

  has_many :subscriptions

  def admin?
    role == 'admin'
  end

  def currently_subscribed?
    subscribed_at?(DateTime.current)
  end

  def subscribed_at? datetime
    admin? || subscriptions.where("date_start <= ? AND date_end >= ?", datetime, datetime).present?
  end

  def in_trial_period?
    return false if admin?
    return false if currently_subscribed?
    confirmed_at < DateTime.current + 7.days
  end
end
