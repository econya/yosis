# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Admin::AdminController < ApplicationController
  private
    def back_url_or other_url
      params[:back_path] || other_url
    end
end


