# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

module Admin::EditButtonHelper
  def admin_edit_button path
    content_tag :a, href: path, class: 'button is-dark admin_edit_button' do
      content_tag :span, class: 'icon' do
        tag.i(class: "fas fa-user-shield")
      end
    end
  end
end

