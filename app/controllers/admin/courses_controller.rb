# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Admin::CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  def index
    @courses = Course.all.rank(:row_order)
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: t('admin.courses.creation-succes') }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /courses/1
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: t('admin.courses.update-succes') }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /courses/1
  def destroy
    begin
      @course.destroy
      redirect_to courses_url, notice: t('admin.courses.deletion-success')
    rescue ActiveRecord::InvalidForeignKey
      redirect_to courses_url, alert: t('admin.courses.cannot-delete-with-videos')
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:name, :description, :active)
    end
end
