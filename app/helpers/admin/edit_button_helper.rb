# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

module Admin::EditButtonHelper
  # Add a div and a button around the content if current user is admin
  # the button will lead to edit_path: and a paramter pointing to current page
  # will be added.
  def admin_edit_area(edit_path:, back_anchor: '', &block)
    content = capture(&block)

    if !user_signed_in? || current_user.role != 'admin'
      concat content
    else
      back_anchor = "##{back_anchor}" if back_anchor.present?

      back_url = edit_path + '?' + URI.
        encode_www_form([['back_path', request.path + back_anchor]])

      edit_button = content_tag :a, href: back_url,
        class: 'button is-dark admin-button' do
        content_tag(:span, class: :icon) do
          tag.i(class: 'fas fa-user-shield')
        end
      end

      concat content_tag(:div,
        content + edit_button.html_safe,
        class: 'admin-edit-area',
        data: { controller: 'class_toggle',
                action: 'mouseenter->class_toggle#highlight ' +
                        'mouseleave->class_toggle#downlight',
               },
        # could not figure out the correct nested data-syntax :(
        "data-class_toggle-toggle_class" => 'has-black-border')
    end
  end

  def admin_edit_button path
    return if !user_signed_in? || current_user.role != 'admin'

    back_url = path + '?' + URI.
      encode_www_form([['back_path', request.path]])

    content_tag :div, class: 'admin_edit_button', data: {controller: 'admin_button'} do
      @content = content_tag :a, href: back_url,
        class: 'button is-dark',
        data: {action: 'mouseenter->admin_button#highlight ' +
                       'mouseleave->admin_button#downlight'} do
        content_tag(:span, class: 'icon') do
          tag.i(class: "fas fa-user-shield")
        end
      end
      @content << content_tag(:a, class: 'button',
                              class: 'delete hide-admin-button',
                              onclick: 'hide_admin_buttons();') do
        "hide"
      end
    end
  end
end

