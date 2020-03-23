# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Admin::AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  # GET /appointments
  def index
    @future_appointments = Appointment.future
    @past_appointments   = Appointment.past
  end

  # GET /appointments/1
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  def create
    @appointment = Appointment.new(appointment_params)

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to admin_appointments_path, notice: 'Appointment was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /appointments/1
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to [:admin, @appointment], notice: 'Appointment was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /appointments/1
  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to admin_appointments_url, notice: 'Appointment was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def appointment_params
      params.require(:appointment).permit(:date_from, :date_to, :course_id, :notice, :link)
    end
end
