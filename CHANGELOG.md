<!--
SPDX-FileCopyrightText: 2020 Felix Wolfsteller
SPDX-License-Identifier: AGPL-3.0-or-later
-->
# Changelog for yosis

This Changelog should mention the most important changes and fixes of every
release. It is mainly targeted towards Users.

## [Unreleased]

#### Added
- Let admin define asana order manually (with some restrictions)
#### Changed
#### Fixed
#### Removed

## [0.4.0] - 2021-01-05
#### Added
- Included Blog module
- Add courses, places, styles (representing "physical" courses)
- Add Asana Lexicon
#### Changed
- Reworked the complete layout
#### Fixed
#### Removed
The whole appointment system alltogether is gone now.

## [0.3.x] 2020
#### Added
- For SEO/structured metadata: add very basic, not configurable LD/JSON and og
- Courses now have a description.
#### Changed
- Let appointment form show the minutes in 5 minute steps in date fields
  (instead of showing every minute)
- Let Rails add Cache-Control headers to assets in production when serving them
- change about-us URL (from about_us)
#### Fixed
#### Removed

## [0.3.1] - 2020-04-19

#### Added
- Generate a sitemap on `web` Procfile run (#19).
- favicon upload possibility (#3).
- Tags in HTML head (canonical URL, description, author).
#### Changed
#### Fixed
- Do not show 'more' videos if there are only three.
#### Removed


## [0.3.0] - 2020-04-06

#### Added
- Add 'impersonate' action for admins from show-single-user page.
- Show logged in users their current trial/subscription state (#10).
- Send out reminders via mail regularly: two days before trial period ends, 5
  days before subscriptions end.
- A contact/feedback form and mailer.
- Background jobs can manually be triggered (interesting for cron jobs).
#### Changed
- Allow users in trial to watch the first (last) three videos of every course.
- When more than 4 video cards were shown on home, display three and one to link
  to "more".
#### Fixed
- Minor visual glitches.

## [0.2.4] - 2020-04-05

#### Added
- Protect from sign-up spam using the `invisible_captcha` gem.
- Protect from automated sign-in attempts using the `Rack::Attack`.
#### Changed
- Require Ruby 2.6.6 .

## [0.2.3] - 2020-04-04

Initial version regarding the Changelog.

#### Added
- Added CHANGELOG.md

[unreleased]: https://github.com/econya/yosis/compare/0.3.1...HEAD
[0.3.1]: https://github.com/econya/yosis/compare/0.3.0...0.3.1
[0.3.0]: https://github.com/econya/yosis/compare/0.2.4...0.3.0
[0.2.4]: https://github.com/econya/yosis/compare/0.2.3...0.2.4
[0.2.3]: https://github.com/econya/yosis/releases/tag/0.2.3
