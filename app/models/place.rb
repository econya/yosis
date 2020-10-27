# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Place < ApplicationRecord
  extend FriendlyId
  include RankedModel
  include Deactivateable

  ranks :row_order, scope: :active

  has_many :courses

  validates :name, presence: true

  friendly_id :name, use: :slugged

  scope :which_has_courses, -> { where(id: Course.active.select(:place_id)) }

  scope :which_has_active_courses, -> { where(id: Course.active.pluck(:place_id)) }
end
