# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class StylesController < ApplicationController
  before_action :set_style, only: [:show]

  # GET /styles
  def index
    @styles = Style.active.rank(:row_order)
  end

  # GET /style/1
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_style
      @style = Style.friendly.find(params[:id])
    end
end
