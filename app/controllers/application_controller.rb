# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :force_terms_acceptance
  impersonates :user

  def authorize_admin!
    if true_user&.admin?
      # happy face
    else
      flash[:error] = t('problems.not_authorized')
      redirect_to root_path
    end
  end

  def authorize_user!
    if !user_signed_in?
      flash[:error] = t('problems.you_need_to_log_in')
      redirect_to root_path
    end
  end

  def force_terms_acceptance
    if user_signed_in? && current_user == true_user
      if !current_user.admin? && !current_user.terms_accepted_at
        redirect_to terms_acceptance_path
      end
    end
  end
end
