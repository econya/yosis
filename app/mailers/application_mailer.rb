# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class ApplicationMailer < ActionMailer::Base
  default from: ENV['SENDER_EMAIL'] || 'yosismail'
  layout 'mailer'
end
