# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class AdminUsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should not get index when unauthenticated" do
    get admin_users_url
    assert_response :redirect
  end

  test "should not get index when unauthorized" do
    sign_in users(:user)
    get admin_users_url
    assert_response :redirect
  end

  test "should get index as admin" do
    sign_in users(:admin)
    get admin_users_url
    assert_response :success
  end

  test "should get user details" do
    sign_in users(:admin)
    get admin_user_url(users(:user))
    assert_response :success
  end
end
