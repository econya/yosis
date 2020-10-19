# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class AsanaAsanaFamily < ApplicationRecord
  belongs_to :asana, inverse_of: :asana_asana_families
  belongs_to :asana_family, inverse_of: :asana_asana_families
end

