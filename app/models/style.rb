# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Style < ApplicationRecord
  extend FriendlyId
  include RankedModel
  include Deactivateable

  ranks :row_order

  has_one_attached :image

  has_many :courses, inverse_of: :style
  has_many :lessons, inverse_of: :style

  has_many :active_courses, -> { active },
    source: :course,
    class_name: 'Course',
    inverse_of: :style

  validates :name, presence: true, length: { minimum: 2 }, uniqueness: true

  scope :which_has_courses, -> { where(id: Course.active.select(:style_id)) }
  scope :which_has_videos,  -> { where(id: Lesson.active.select(:style_id)) }

  friendly_id :name, use: :slugged
end
