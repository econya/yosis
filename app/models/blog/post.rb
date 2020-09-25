# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Blog::Post < ApplicationRecord
  extend FriendlyId
  include Deactivateable

  friendly_id :title, use: :slugged

  has_one_attached :image

  def previous
    Blog::Post.active.where("created_at < ?", created_at).order(created_at: :asc).where.not(id: id).first
  end

  def next
    Blog::Post.active.where("created_at > ?", created_at).order(created_at: :asc).where.not(id: id).first
  end
end
