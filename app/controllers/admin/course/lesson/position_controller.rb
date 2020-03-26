# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Admin::Course::Lesson::PositionController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  before_action :set_lesson, only: [:create, :destroy]

  def create
    @lesson.update(row_order_position: :up)
    redirect_back fallback_location: :root_path
  end

  def destroy
    @lesson.update(row_order_position: :down)
    redirect_back fallback_location: :root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.friendly.find(params[:lesson_id])
    end
end
