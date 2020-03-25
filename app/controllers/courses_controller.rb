# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class CoursesController < ApplicationController
  before_action :set_course, only: [:show]

  # GET /courses
  def index
    @courses = Course.active.rank(:row_order)
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
