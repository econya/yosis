# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class TermsAcceptancesController < ApplicationController
  before_action :authorize_user!
  before_action :force_terms_acceptance

  def show
    if !current_user.terms_accepted_at.present?
      flash[:warning] = t('.have_to_agree')
    end
  end

  def create
    if params[:accept_terms] && params[:read_privacy_terms]
      flash[:message] = t('.welcome')
      current_user.update(terms_accepted_at: DateTime.current)
      redirect_to root_path
    else
      flash[:warning] = t('terms_acceptances.show.have_to_agree')
      render :show
    end
  end

  private

  def force_terms_acceptance
    # no show (overriding ApplicationController#force_terms_acceptance,
    # otherwise redirect loop)
  end
end

