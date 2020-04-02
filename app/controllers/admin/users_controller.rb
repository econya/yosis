# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    @pagy, @users = pagy_arel(User.order(created_at: :asc).all, items: 20)
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    if @user.admin?
      redirect_to admin_users_url, alert: t('admin.users.cannot-delete-admins')
    elsif @user.currently_subscribed?
      redirect_to admin_users_url, alert: t('admin.users.cannot-delete-subscribed-users')
    else
      @user = User.find(params[:id])
      @user.destroy
      redirect_to admin_users_url, notice: t('admin.users.deletion-success', email: @user.email)
    end
  end

  # using 'pretender' gem
  def impersonate
    user = User.find(params[:id])
    impersonate_user(user)
    redirect_to root_path
  end

  # using 'pretender' gem
  def stop_impersonating
    stop_impersonating_user
    redirect_to root_path
  end
end

