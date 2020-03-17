# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
class Navigation
  include Rails.application.routes.url_helpers

  attr_reader :items

  def initialize
    @items = []

    item 'Home',      path: root_path
    item 'Courses',   path: courses_path
    item 'Customers', path: customers_path
    item 'Settings'
  end

  def item title, icon: nil, path: nil
    @items << NavigationItem.new(title: title, path: path)
  end
end
