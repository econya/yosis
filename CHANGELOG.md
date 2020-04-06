# Changelog for yosis

This Changelog should mention the most important changes and fixes of every
release. It is mainly targeted towards Users.

## [Unreleased]

#### Added
- Add 'impersonate' action for admins from show-single-user page.
- Show logged in users their current trial/subscription state (#10).
- Send out reminders via mail regularly: two days before trial period ends, 5
  days before subscriptions end.
- A contact/feedback form and mailer.
#### Changed
- Allow users in trial to watch the first (last) three videos of every course.
- When more than 4 video cards were shown on home, display three and one to link
  to "more".
#### Fixed
- Minor visual glitches
#### Removed

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

[unreleased]: https://github.com/econya/yosis/compare/0.2.4...HEAD
[0.2.4]: https://github.com/econya/yosis/compare/0.2.3...0.2.4
[0.2.3]: https://github.com/econya/yosis/releases/tag/0.2.3
