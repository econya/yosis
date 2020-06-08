# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Course < ApplicationRecord
  extend FriendlyId
  include RankedModel
  ranks :row_order

  belongs_to :place
  belongs_to :style

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where.not(active: true) }

  friendly_id :name, use: :slugged
end
