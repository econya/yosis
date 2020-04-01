# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    @users = User.order(created_at: :asc).all
  end

  def show
    @user = User.find(params[:id])
  end

  def impersonate
    user = User.find(params[:id])
    impersonate_user(user)
    redirect_to root_path
  end

  def stop_impersonating
    stop_impersonating_user
    redirect_to root_path
  end
end

