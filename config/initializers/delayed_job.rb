# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

# TODO find out the defaults, mention them here.
Delayed::Worker.destroy_failed_jobs = false

Delayed::Worker.max_run_time = 15.minutes # (default: 4.hours)



