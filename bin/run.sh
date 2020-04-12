#!/bin/sh

# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

rails sitemap:refresh:no_ping
bundle exec puma -C config/puma.rb
