# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

module UserAccessHelper
  def user_has_access?
    user_signed_in? && current_user.role == 'admin' || current_user.in_trial_period?
  end
end

