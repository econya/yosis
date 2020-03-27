require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "shows page" do
    get root_path
    assert_response :success
  end

  test "shows rendered about_us page" do
    terms_setting = SiteSetting.find_or_create_by(key: 'about_us',
                                                  value: '# about us head',
                                                  kind: 'markdown')

    get about_us_path

    assert_select 'h1', 'about us head'
    assert_response :success
  end

  test "shows rendered term page" do
    terms_setting = SiteSetting.find_or_create_by(key: 'terms',
                                                  value: '# term-heading',
                                                  kind: 'markdown')

    get terms_path

    assert_select 'h1', 'term-heading'
    assert_response :success
  end

  test "shows rendered privacy statement page" do
    terms_setting = SiteSetting.find_or_create_by(key: 'privacy_statement',
                                                  value: '# privacy',
                                                  kind: 'markdown')

    get privacy_path

    assert_select 'h1', 'privacy'
    assert_response :success
  end
end
