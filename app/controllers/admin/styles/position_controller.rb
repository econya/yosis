# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Admin::Styles::PositionController < Admin::PositionController
  def referenced_model
    Style
  end
end
