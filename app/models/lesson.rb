# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Lesson < ApplicationRecord
  extend FriendlyId
  belongs_to :course

  has_one_attached :video
  has_one_attached :preview_image

  validates :name, presence: true

  friendly_id :name, use: :slugged
end
