# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Contact
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :subject
  attribute :message
  attribute :sender_email
  attribute :phone_number

  validate :phone_or_mail_present
  validates :message, :subject, presence: true
  validates :sender_email, format: { with: /.+@.+\..+/}, allow_blank: true

  def phone_or_mail_present
    if !phone_number.present? && !sender_email.present?
      errors.add(:sender_email, :need_either_mail_or_phone)
    end
  end
end

