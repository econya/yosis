# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Course < ApplicationRecord
  extend FriendlyId
  include RankedModel
  include Deactivateable

  ranks :row_order

  belongs_to :place
  belongs_to :style

  friendly_id :name, use: :slugged

  validates :dayofweek, numericality: { only_integer: true, greater_than_or_equal: 0, less_than: 7 }
end
