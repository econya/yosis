# SPDX-FileCopyrightText: 2022 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class SeminarsController < ApplicationController
  def index
    @seminars = Seminar.active.with_attached_image.rank(:row_order)
  end

  # GET /seminar/:id
  def show
    @seminar = Seminar.friendly.find(params[:id])
  end
end
