# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Admin::StylesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  before_action :set_style, only: [:show, :edit, :update, :destroy]

  # GET /styles
  def index
    @styles = Style.all.rank(:row_order)
  end

  # GET /style/new
  def new
    @style = Style.new
  end

  # GET /styles/1/edit
  def edit
  end

  # POST /styles
  def create
    @style = Style.new(style_params)

    respond_to do |format|
      if @style.save
        format.html { redirect_to @style, notice: t('admin.styles.creation-succes') }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /styles/1
  def update
    respond_to do |format|
      if @style.update(style_params)
        format.html { redirect_to @style, notice: t('admin.styles.update-succes') }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /styles/1
  def destroy
    begin
      @style.destroy
      redirect_to styles_url, notice: t('admin.styles.deletion-success')
    rescue ActiveRecord::InvalidForeignKey
      redirect_to styles_url, alert: t('admin.styles.cannot-delete-with-videos')
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_style
      @style = Style.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def style_params
      params.require(:style).permit(:name, :description, :image, :active)
    end
end
