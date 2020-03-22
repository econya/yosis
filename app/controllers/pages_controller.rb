# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class PagesController < ApplicationController
  def home
    @courses = Course.all
  end
end
