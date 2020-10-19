# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class AsanaFamily < ApplicationRecord
  has_many :asana_asana_families, inverse_of: :asana_family
  has_many :asanas, through: :asana_asana_families, inverse_of: :asana_families
end
