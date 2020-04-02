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
      'alert'   => 'is-danger'
      'warning' => 'is-warning'
    }.freeze
  end
end

