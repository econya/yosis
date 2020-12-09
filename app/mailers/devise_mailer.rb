# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class DeviseMailer < Devise::Mailer

  def confirmation_instructions(record, token, opts={})
    mail = super
    mail.subject = "%s: %s" % [SiteSettings.fetch('title').value, mail.subject]
    mail
  end

end
