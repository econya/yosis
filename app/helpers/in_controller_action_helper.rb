# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

module InControllerActionHelper
  def in_controller_action?(controller:, action:)
    controller_name == controller && current_page?(action: action)
  end
end

