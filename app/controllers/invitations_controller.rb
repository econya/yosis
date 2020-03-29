# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class InvitationsController < Devise::InvitationsController
  private
    # this is called when accepting invitation
    # should return an instance of resource class
    def accept_resource
      resource = super
      # is it "@user"?
      AdminMailer.invitation_accepted(resource).deliver #later
      resource
    end
end
