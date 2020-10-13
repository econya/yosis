# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Admin::AdminController < ApplicationController
  private
    def back_url_or other_url
      if params[:back_path].empty?
        other_url
      else
        params[:back_path]
      end
    end
end


