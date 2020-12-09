# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class DeviseMailer < Devise::Mailer

  def confirmation_instructions(record, token, opts={})
    mail = super
    mail.subject = prepend_title mail.subject
    mail
  end

  def reset_password_instructions(record, token, opts = {})
    mail = super
    mail.subject = prepend_title mail.subject
    mail
  end


  private

  def prepend_title string
    "%s: %s" % [SiteSettings.fetch('title').value, string]
  end

end
