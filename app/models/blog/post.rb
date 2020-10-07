# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Blog::Post < ApplicationRecord
  extend FriendlyId
  include Deactivateable

  friendly_id :title, use: :slugged

  has_one_attached :image

  scope :published, -> { active.where("published_at NOT NULL") }

  # Not using a scope here because of 'first'
  def self.last_within days: 7.days
    active.where('published_at > ?', DateTime.current - days)
      .order(published_at: :desc)
      .limit(1)
      .first
  end

  def previous
    Blog::Post.active.where("created_at < ?", created_at).order(created_at: :asc).where.not(id: id).first
  end

  def next
    Blog::Post.active.where("created_at > ?", created_at).order(created_at: :asc).where.not(id: id).first
  end
end
