# SPDX-FileCopyrightText: 2021 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Admin::Asana::PositionController < Admin::PositionController
  # TODO we fake a bit the "per has_many" aspect of ordering
  # therefore create and destroy might need more parameters
  def referenced_model
    Asana
  end

  private
    def entity
      referenced_model.find(referenced_model_id)
    end

end
