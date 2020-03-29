# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Contact
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :subject
  attribute :message
end

