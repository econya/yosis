# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class ContactsController < ApplicationController
  before_action :authenticate_user!

  def new
    @contact = Contact.new
  end

  def create
    contact = Contact.new(contact_params)
    ContactMailer.with(user: current_user,
                       subject: contact.subject,
                       message: contact.message).feedback().deliver_later
    redirect_to root_path, notice: t('contact.sent_thanks')
  end

  def show
    # This could be hello, thanks
  end

  private
  def contact_params
    params.require(:contact).permit(:subject, :message)
  end
end
