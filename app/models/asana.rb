# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Asana < ApplicationRecord
  has_many :asana_names, inverse_of: :asana

  has_many :german_asana_names,
    -> { in_de },
    source: :asana_name,
    class_name: 'AsanaName'
  has_many :english_asana_names,
    -> { in_en },
    class_name: 'AsanaName'
  has_many :sanskrit_asana_names,
    -> { in_sanskrit },
    class_name: 'AsanaName'

  has_many :asana_asana_families, inverse_of: :asana
  has_many :asana_families, through: :asana_asana_families, inverse_of: :asanas

  has_one_attached :image

  accepts_nested_attributes_for :asana_names,
    allow_destroy: true, reject_if: :empty_name_or_language_code?
  accepts_nested_attributes_for :german_asana_names,
    allow_destroy: true, reject_if: :empty_name_or_language_code?
  accepts_nested_attributes_for :english_asana_names,
    allow_destroy: true, reject_if: :empty_name_or_language_code?
  accepts_nested_attributes_for :sanskrit_asana_names,
    allow_destroy: true, reject_if: :empty_name_or_language_code?

  private
    def empty_name_or_language_code?(attributes)
      attributes['language_code'].blank? || attributes['name'].blank?
    end
end
