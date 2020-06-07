# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Style < ApplicationRecord
  extend FriendlyId
  include RankedModel
  ranks :row_order

  has_one_attached :image

  has_many :lessons
  has_many :appointments

  validates :name, presence: true, length: { minimum: 2 }, uniqueness: true

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where.not(active: true) }

  friendly_id :name, use: :slugged
end
