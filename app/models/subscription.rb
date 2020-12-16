# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Subscription < ApplicationRecord
  belongs_to :user

  validates :date_start, presence: true
  validates :date_end, presence: true

  validate :start_before_end

  scope :current, -> { where("date_start <= ? AND date_end >= ?", DateTime.current, DateTime.current) }

  scope :at, ->(day: DateTime.current) { where("date_start <= ? AND date_end >= ?", day, day) }

  def active_today?
    (date_start..date_end).include? DateTime.current
  end

  private

  def start_before_end
    if date_end < date_start
      errors.add(:date_end, :must_be_before_start_date)
    end
  end

end
