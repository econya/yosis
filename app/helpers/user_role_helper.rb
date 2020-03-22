# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

module UserRoleHelper
  def user_admin?
    user_signed_in? && current_user.role == 'admin'
  end
end
