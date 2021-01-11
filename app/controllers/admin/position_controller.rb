# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Admin::PositionController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  #before_action :set_entity, only: [:create, :destroy]

  # One position up
  def create
    entity.update(row_order_position: :up)
    redirect_back fallback_location: :root_path
  end

  # One position down
  def destroy
    entity.update(row_order_position: :down)
    redirect_back fallback_location: :root_path
  end

  # To defined position
  def update
    entity.update(row_order_position: position_params)
    redirect_back fallback_location: :root_path
  end

  private
    def entity
      referenced_model.friendly.find(referenced_model_id)
    end

    def referenced_model
      raise NotImplementedError("Need to subclass position_controller")
    end

    def referenced_model_id
      params[referenced_model_id_param_name]
    end

    def referenced_model_id_param_name
      (referenced_model.to_s.downcase + "_id").to_sym
    end

    def position_params
      params.permit(:position)[:position]
    end
end

