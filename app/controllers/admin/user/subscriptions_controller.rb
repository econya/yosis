# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Admin::User::SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  before_action :set_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_admin_subscription, only: [:edit, :update, :destroy]

  # GET /admin/subscriptions/new
  def new
    @subscription = @user.subscriptions.new
  end

  # GET /admin/subscriptions/1/edit
  def edit
  end

  # POST /admin/subscriptions
  def create
    @subscription = @user.subscriptions.new(subscription_params)

    if @subscription.save
      redirect_to [:admin, @subscription.user], notice: t('.creation-successfull')
    else
      render :new
    end
  end

  # PATCH/PUT /admin/subscriptions/1
  def update
    respond_to do |format|
      if @subscription.update(subscription_params)
        format.html { redirect_to [:admin, @subscription.user], notice: t('.update-successful') }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/subscriptions/1
  def destroy
    @subscription.destroy
    respond_to do |format|
      format.html { redirect_to [:admin, @subscription.user], notice: t('.destroy-success') }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_admin_subscription
      @subscription = Subscription.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def subscription_params
      params.require(:subscription).permit(:user_id, :date_start, :date_end, :notes)
    end
end
