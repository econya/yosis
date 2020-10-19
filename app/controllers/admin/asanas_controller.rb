# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Admin::AsanasController < Admin::AdminController
  before_action :authenticate_user!
  before_action :authorize_admin!

  before_action :set_asana, only: [:show, :edit, :update, :destroy]

  # GET /asanas
  def index
    @asanas = Asana.all
  end

  # GET /asanas/1
  def show
  end

  # GET /asanas/new
  def new
    @asana = Asana.new
  end

  # GET /asanas/1/edit
  def edit
  end

  # POST /asanas
  def create
    @asana = Asana.new(asana_params)

    if params[:new_family]
      family = AsanaFamily.find_or_create_by!(name: params[:new_family])
      @asana.asana_families << family
    end

    respond_to do |format|
      if @asana.save
        format.html { redirect_to admin_asanas_path,
                        notice: t('admin.asana.creation-success') }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /asanas/1
  def update
    update_success = @asana.update(asana_params)

    if params[:new_family]
      family = AsanaFamily.find_or_create_by!(name: params[:new_family])
      @asana.asana_families << family
    end

    respond_to do |format|
      if update_success
        format.html { redirect_to back_url_or(admin_asanas_path),
                        notice: t('admin.asana.update-success') }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /asanas/1
  def destroy
    @asana.destroy
    respond_to do |format|
      format.html { redirect_to admin_asanas_url,
                      notice: t('admin.asana.deletion-success') }
    end
  end

  private
    def set_asana
      @asana = Asana.find(params[:id])
      # should include or join the names
    end

    def asana_params
      params.require(:asana).permit(
        :asana_family_ids,
        asana_names_attributes: [:language_code, :name, :id, :_destroy],
        german_asana_names_attributes: [:language_code, :name, :id, :_destroy],
        english_asana_names_attributes: [:language_code, :name, :id, :_destroy],
        sanskrit_asana_names_attributes: [:language_code, :name, :id, :_destroy],
      )
    end
end
