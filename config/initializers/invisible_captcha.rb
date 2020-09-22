# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

InvisibleCaptcha.setup do |config|
  config.timestamp_enabled = !Rails.env.test?
end
