# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

module Deactivateable
  extend ActiveSupport::Concern

  included do
    scope :active,   -> { where(active: true) }
    scope :inactive, -> { where.not(active: true) }
  end
end
