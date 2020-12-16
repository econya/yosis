# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class AddMarkPaidAtToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :mark_paid_at, :datetime
  end
end
