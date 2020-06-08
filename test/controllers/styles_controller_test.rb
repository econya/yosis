# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class StylesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @style = styles(:base_yoga)
  end

  test "should get index" do
    get styles_url
    assert_response :success
  end

  test "should show style" do
    get style_url(@style)
    assert_response :success
  end
end
