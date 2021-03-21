# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class CoursesController < ApplicationController
  before_action :set_course, only: [:show]

  # GET /courses
  def index
    @courses = Course.active.rank(:row_order)
    @styles = Style.includes(:lessons).
      with_attached_image.active.rank(:row_order)

    @places = Place.active.rank(:row_order)

    @html_title = t('courses.local')
  end

  # GET /courses/1
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.friendly.find(params[:id])
    end
end
