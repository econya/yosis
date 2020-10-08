# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class ContactsController < ApplicationController
  invisible_captcha only: [:create, :show], on_spam: :log_spam

  def new
    @contact = Contact.new
  end

  def create
    contact_values = contact_params
    @contact = Contact.new(contact_values)
    if user_signed_in?
      @contact.sender_email = current_user.email
      sender_mail_param = ActionController::Parameters.new(
        sender_email: current_user.email).permit(:sender_email)
      contact_values.merge!(sender_mail_param)
    end

    if @contact.valid?
      ContactMailer.with(contact_params: contact_values)
        .feedback().deliver_later

      redirect_to root_path, notice: t('contact.sent_thanks')
    else
      # Need to setup the environment for Pages#home
      @styles = Style.active.rank(:row_order)
      @places = Place.active.all
      render template: 'pages/home'
    end
  end

  def show
    # This could be hello, thanks
  end

  private
  def contact_params
    params.require(:contact).permit(:subject, :message, :sender_email, :phone_number)
  end

  def log_spam
    Rails.logger.info 'invisible_captcha prevented a spam contact'
    head 200
  end
end
