# SPDX-FileCopyrightText: 2022 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Seminar < ApplicationRecord
  extend FriendlyId
  include RankedModel
  include Deactivateable

  ranks :row_order

  validates :name, presence: true, length: { minimum: 5 }, uniqueness: true

  friendly_id :name, use: :slugged

  has_one_attached :image

  before_save :render_markdown,
    if: -> {description_changed? || description.present? != description_rendered.present?}

  def render_markdown
    renderer = Redcarpet::Render::HTML.new(with_toc_data: true)
    assign_attributes({
      description_rendered: Redcarpet::Markdown.new(renderer).render(description)
    })
  end
end
