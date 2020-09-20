# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class AdminStylesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @style = styles(:base_yoga)
  end

  test "should not get index when unauthenticated" do
    get admin_styles_url
    assert_response :redirect
  end

  test "should not get index when unauthorized" do
    sign_in users(:user)
    get admin_styles_url
    assert_response :redirect
  end

  test "should get index" do
    sign_in users(:admin)
    get admin_styles_url
    assert_response :success
  end

  test "should get new" do
    sign_in users(:admin)
    get new_admin_style_url
    assert_response :success
  end

  test "should create style and redirect to nonadmin view" do
    sign_in users(:admin)
    assert_difference('Style.count') do
      post admin_styles_url, params: { style: { name: @style.name + ' difference ' } }
    end

    assert_redirected_to style_url(Style.last)
  end

  test "should get edit" do
    sign_in users(:admin)
    get edit_admin_style_url(@style)
    assert_response :success
  end

  test "should update style and redirect to nonadmin index" do
    sign_in users(:admin)
    patch admin_style_url(@style), params: { style: { name: @style.name } }
    assert_redirected_to style_url(@style)
  end

  test "should not destroy style with lessons" do
    sign_in users(:admin)
    assert_difference('Style.count', 0) do
      delete admin_style_url(@style)
    end

    assert_redirected_to styles_url
  end

  test "should destroy style only if has no lesson" do
    sign_in users(:admin)
    assert_difference('Style.count', -1) do
      delete admin_style_url(styles(:style_without_lessons))
    end

    assert_redirected_to styles_url
  end
end
