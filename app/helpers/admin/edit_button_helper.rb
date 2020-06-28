# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

module Admin::EditButtonHelper
  def admin_edit_button path
    return if !user_signed_in? || current_user.role != 'admin'
    content_tag :div, class: 'admin_edit_button' do
      @content = content_tag :a, href: path, class: 'button is-dark' do
        content_tag(:span, class: 'icon') do
          tag.i(class: "fas fa-user-shield")
        end
      end
      @content << content_tag(:a, class: 'button', class: 'delete hide-admin-button', onclick: 'hide_admin_buttons();') do
        "hide"
      end
    end
  end
end

