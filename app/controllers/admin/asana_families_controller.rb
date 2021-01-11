# SPDX-FileCopyrightText: 2020,2021 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Admin::AsanaFamiliesController < Admin::AdminController
  before_action :authenticate_user!
  before_action :authorize_admin!

  before_action :set_asana_family, only: [:show]

  # GET /asana_families
  def index
    @asanas = Asana.includes(:german_asana_names,
                             :english_asana_names,
                             :sanskrit_asana_names).rank(:row_order).all
  end

  # GET /asana_families/1
  def show
  end

  private
    def set_asana_family
      @asana_family = AsanaFamily.find(params[:id])
      # should include or join the names
    end
end
