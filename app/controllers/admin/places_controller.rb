# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Admin::PlacesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  before_action :set_place, only: [:show, :edit, :update, :destroy]

  # GET /places
  def index
    @places = Place.all
  end

  # GET /places/1
  def show
  end

  # GET /places/new
  def new
    @place = Place.new
  end

  # GET /places/1/edit
  def edit
  end

  # POST /places
  def create
    @place = Place.new(place_params)

    respond_to do |format|
      if @place.save
        format.html { redirect_to admin_places_path, notice: t('admin.place.creation-success') }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /places/1
  def update
    respond_to do |format|
      if @place.update(place_params)
        format.html { redirect_to admin_places_path, notice: t('admin.place.update-success') }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /places/1
  def destroy
    @place.destroy
    respond_to do |format|
      format.html { redirect_to admin_places_url, notice: t('admin.place.deletion-success') }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def place_params
      params.require(:place).permit(:name, :building_name, :note,
                                    :pricing_note, :address, :active)
    end
end
