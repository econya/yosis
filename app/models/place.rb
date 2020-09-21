# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Place < ApplicationRecord
  extend FriendlyId
  include RankedModel
  include Deactivateable

  ranks :row_order, scope: :active

  validates :name, presence: true

  friendly_id :name, use: :slugged

end
