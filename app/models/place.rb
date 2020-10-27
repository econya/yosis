# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Place < ApplicationRecord
  extend FriendlyId
  include RankedModel
  include Deactivateable

  ranks :row_order, scope: :active

  has_many :courses, inverse_of: :place

  has_many :active_courses, -> { active },
    source: :course,
    class_name: 'Course',
    inverse_of: :place

  validates :name, presence: true

  friendly_id :name, use: :slugged

  scope :which_has_courses, -> { where(id: Course.active.select(:place_id)) }

  scope :which_has_active_courses, -> { where(id: Course.active.pluck(:place_id)) }

  scope :with_active_course_info, -> { includes(active_courses: :style) }
end
