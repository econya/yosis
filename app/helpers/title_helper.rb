# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

module TitleHelper
  def set_title(title)
    content_for(:html_title, title)
  end
end

