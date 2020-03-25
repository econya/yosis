# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Admin::Course::PositionController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  before_action :set_course, only: [:create, :destroy]

  def create
    @course.update(row_order_position: :up)
    redirect_back fallback_location: :root_path
  end

  def destroy
    @course.update(row_order_position: :down)
    redirect_back fallback_location: :root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.friendly.find(params[:course_id])
    end
end
