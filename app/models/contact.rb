# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Contact
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :subject
  attribute :message
  attribute :sender_email

  validates :message, :subject, presence: true
  validates :message, length: { minimum: 10 }
  validates :sender_email, format: { with: /.+@.+\..+/}, allow_blank: false
end

