# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

module BulmaFlashHelper
  def bulma_flash_class
    {
      # Not used: is-primary
      'success' => 'is-success',
      'error'   => 'is-danger',
      'info'    => 'is-info',
      'alert'   => 'is-alert', # changed to is-alert so that there is no icon, if there is more than one message the icon indents the first message which looks bad.
      'warning' => 'is-warning'
    }.freeze
  end
end

