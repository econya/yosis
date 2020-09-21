# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class Admin::SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:user)
    @subscription = subscriptions(:one)
  end

  test "should not get new as nobody" do
    get new_admin_user_subscription_url(@user)
    assert_response :redirect
  end

  test "should not get new as non-admin users" do
    sign_in users(:user)
    get new_admin_user_subscription_url(@user)
    assert_response :redirect
  end

  test "should get new" do
    sign_in users(:admin)
    get new_admin_user_subscription_url(@user)
    assert_response :success
  end

  test "should create subscription" do
    sign_in users(:admin)
    assert_difference('Subscription.count') do
      post admin_user_subscriptions_url(@subscription.user, @subscription), params: {
        subscription: {
          date_end: @subscription.date_end, date_start: @subscription.date_start, notes: @subscription.notes, user_id: @subscription.user_id } }
    end

    assert_redirected_to admin_user_url(@user)#Subscription.last)
  end

  test "should get edit" do
    sign_in users(:admin)
    get edit_admin_user_subscription_url(@user, @subscription)
    assert_response :success
  end

  test "should update subscription" do
    sign_in users(:admin)
    patch admin_user_subscription_url(@user, @subscription), params: { subscription: { date_end: @subscription.date_end, date_start: @subscription.date_start, notes: @subscription.notes, user_id: @subscription.user_id } }
    assert_redirected_to admin_user_url(@user)#subscription_url(@subscription)
  end

  test "should destroy subscription" do
    sign_in users(:admin)
    assert_difference('Subscription.count', -1) do
      delete admin_user_subscription_url(@subscription.user, @subscription)
    end

    assert_redirected_to admin_user_url(@subscription.user)
  end
end
