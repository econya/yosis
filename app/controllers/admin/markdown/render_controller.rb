# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Admin::Markdown::RenderController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  # POST /admin/markdown/render
  def create
    html = Markdown.new(params[:md], with_toc_data: true).to_html
    render plain: html
  end
end
