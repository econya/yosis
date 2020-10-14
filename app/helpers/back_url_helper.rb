# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

module BackUrlHelper
  def back_url_or other_url
    if params[:back_path].present?
      params[:back_path]
    else
      other_url
    end
  end
end

