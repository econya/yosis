# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Blog::Post < ApplicationRecord
  extend FriendlyId
  include Deactivateable

  friendly_id :title, use: :slugged

  has_one_attached :image

  scope :published, -> { active.where.not(published_at: nil) }

  before_save :render_markdown,
    if: -> {content_changed? || content.present? != content_rendered.present?}

  # Not using a scope here because of 'first'
  def self.last_within days: 7.days
    published.where('published_at > ?', DateTime.current - days)
      .order(published_at: :desc)
      .limit(1)
      .first
  end

  def previous
    Blog::Post.published.where("created_at < ?", created_at)
      .order(created_at: :asc).where.not(id: id).first
  end

  def next
    Blog::Post.published.where("created_at > ?", created_at)
      .order(created_at: :asc).where.not(id: id).first
  end

  def render_markdown
    renderer = Redcarpet::Render::HTML.new(with_toc_data: true)
    assign_attributes({
      content_rendered: Redcarpet::Markdown.new(renderer).render(content)
    })
  end
end
