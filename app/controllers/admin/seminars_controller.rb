# SPDX-FileCopyrightText: 2020,2021 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Admin::SeminarsController < Admin::AdminController
  before_action :authenticate_user!
  before_action :authorize_admin!

  before_action :set_seminar, only: [:edit, :update, :destroy]

  # GET /seminars
  def index
    @seminars = Seminar.all.rank(:row_order)
  end

  # GET /seminar/new
  def new
    @seminar = Seminar.new
  end

  # GET /seminars/1/edit
  def edit
  end

  # POST /seminars
  def create
    @seminar = Seminar.new(seminar_params)

    respond_to do |format|
      if @seminar.save
        format.html { redirect_to admin_seminars_url, notice: t('admin.seminars.creation-success') }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /seminars/1
  def update
    respond_to do |format|
      if @seminar.update(seminar_params)
        format.html { redirect_to admin_seminars_path, notice: t('admin.seminars.update-success') }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /seminars/1
  def destroy
    begin
      @seminar.destroy
      redirect_to seminars_url, notice: t('admin.seminars.deletion-success')
    rescue ActiveRecord::InvalidForeignKey
      redirect_to seminars_url, alert: t('admin.seminars.cannot-delete-with-videos')
    end
  end

  private
    def set_seminar
      @seminar = Seminar.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def seminar_params
      params.require(:seminar).permit(:name, :description, :image, :active)
    end
end
