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

  # GDPR sprinkles
  attribute :tos_agreement
  validates_acceptance_of :tos_agreement, :allow_nil => false, :on => :create

  attribute :read_privacy_terms
  validates_acceptance_of :read_privacy_terms, :allow_nil => false, :on => :create

  scope :with_current_subscription, -> {
    joins(:subscriptions).merge(Subscription.current)
  }
  scope :with_no_current_subscription, -> {
    # OPTIMIZE so that we do not use subquery
    where.not(id: with_current_subscription)
  }
  scope :in_trial, -> {
    # OPTIMIZE so that we do not use subqueries
    where.not("confirmed_at < ?", DateTime.current - 7.days)
    .where(id: with_no_current_subscription)
  }
  scope :trial_started_at, ->(day: Date.current - 5.days) {
    where(confirmed_at: day.all_day)
  }

  def admin?
    role == 'admin'
  end

  def currently_subscribed?
    # TODO: use scope
    subscribed_at?(DateTime.current)
  end

  def subscribed_at? datetime
    # TODO: use scope
    admin? || subscriptions.where("date_start <= ? AND date_end >= ?", datetime, datetime).present?
  end

  def in_trial_period?
    # TODO: use scope
    return false if admin?
    return false if currently_subscribed?
    return false if confirmed_at.nil?
    confirmed_at + 7.days > DateTime.current
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
