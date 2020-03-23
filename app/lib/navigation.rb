# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
class Navigation
  include Rails.application.routes.url_helpers

  attr_reader :items

  def initialize(current_user: nil)
    @items = []

    item I18n.t('Home'),      path: root_path
    item I18n.t('Courses'),   path: courses_path
    item I18n.t('Customers'), path: customers_path
    item I18n.t('Settings') if current_user
  end

  def item title, icon: nil, path: nil
    @items << NavigationItem.new(title: title, path: path)
  end
end
