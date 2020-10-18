# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class AsanaTest < ActiveSupport::TestCase
  test "relations/scopes" do
    first_asana = asanas(:first_asana)
    assert_equal 4, first_asana.asana_names.count

    assert_equal 2, first_asana.asana_names.in_de.count
    assert_equal 1, first_asana.asana_names.in_en.count
    assert_equal 1, first_asana.asana_names.in_sanskrit.count

    assert_equal 2, first_asana.german_asana_names.count
    assert_equal 1, first_asana.english_asana_names.count
    assert_equal 1, first_asana.sanskrit_asana_names.count
  end
end
