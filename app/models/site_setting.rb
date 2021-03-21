# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class SiteSetting < ApplicationRecord
  validates :key, uniqueness: true

  has_one_attached :image

  before_save :render_markdown, if: -> {value_changed? && kind == "markdown"}

  def self.[](setting_name)
    setting = find_by_key(setting_name)
    if setting
      if setting.kind != "markdown"
        return setting.value
      else
        return setting.value_rendered
      end
    end
  end

  def render_markdown
    renderer = Redcarpet::Render::HTML
    assign_attributes({
      value_rendered: Redcarpet::Markdown.new(renderer).render(value)
    })
  end

  def true?
    value == '1'
  end
end
