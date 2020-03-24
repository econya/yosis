# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Admin::Course::LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  before_action :set_lesson, only: [:show, :edit, :update, :destroy]
  before_action :set_course, only: [:new, :create, :edit, :update, :destroy]

  # GET /lessons
  def index
    @lessons = Lesson.all
  end

  # GET /lessons/1
  def show
  end

  # GET /lessons/new
  def new
    @lesson = @course.lessons.new
  end

  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons
  def create
    @lesson = @course.lessons.new(lesson_params)

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to @course, notice: t('Lesson was successfully created.') }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /lessons/1
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to [@lesson.course], notice: t('Lesson was successfully updated.') }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /lessons/1
  def destroy
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to @lesson.course, notice: t('Lesson was successfully destroyed.') }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.friendly.find(params[:id])
    end

    def set_course
      @course = Course.friendly.find(params[:course_id])
    end

    # Only allow a list of trusted parameters through.
    def lesson_params
      params.require(:lesson).permit(:course_id,
        :name, :date_start, :date_end, :video, :preview_image, :active)
    end
end
