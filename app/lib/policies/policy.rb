# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Policies::Policy
  def self.can_see_blog_post user, post
    return false if !post.present?

    return true if user&.admin?

    return false if post.published_at.nil?
    return false if post.published_at >= DateTime.current
    return false if !post.active?

    true
  end
end

