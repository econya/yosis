# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class AsanaName < ApplicationRecord
  DE       = 'de'
  EN       = 'en'
  SANSKRIT = 'sanskrit'

  belongs_to :asana#, inverse_of: :asana_names

  scope :in_de,       -> { where(language_code: DE) }
  scope :in_en,       -> { where(language_code: EN) }
  scope :in_sanskrit, -> { where(language_code: SANSKRIT) }

  def in_de?
    self.language_code == DE
  end

  def in_en?
    self.language_code == EN
  end

  def in_sanskrit?
    self.language_code == SANSKRIT
  end
end
