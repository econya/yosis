# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Course < ApplicationRecord
  extend FriendlyId

  has_one_attached :image

  has_many :lessons
  has_many :appointments

  friendly_id :name, use: :slugged

  validates :name, presence: true, length: { minimum: 2 }, uniqueness: true
end
