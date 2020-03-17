# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class NavigationItem
  attr_reader :title, :path

  def initialize title: title, path: nil
    @title = title
    @path  = path
  end
end
