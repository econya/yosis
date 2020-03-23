# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class ApplicationController < ActionController::Base
  #before_action :authenticate_user!

  def authorize_admin!
    if current_user&.admin?
      # happy face
    else
      flash[:error] = t('not authorized')
      redirect_to root_path
    end
  end
end
