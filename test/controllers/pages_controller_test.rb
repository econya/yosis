require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "shows page" do
    get root_path
    assert_response :success
  end
  test "shows rendered page" do
    terms_setting = SiteSetting.find_or_create_by(key: 'terms',
                                                  value: '# term-heading',
                                                  kind: 'markdown')

    get terms_path

    assert_select 'h1', 'term-heading'
    assert_response :success
  end
end
