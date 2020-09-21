# Yosis video and course platform

yosis is a Ruby on Rails6 Web application to manage (online-) yoga courses and
Free and Open Software, released under the AGPLv3+, copyright Felix Wolfsteller.

The main reason for this code to exist is
[https://online.yogamitveronique.de](https://online.yogamitveronique.de) .

We are happy to support and/or host other platforms like that (but we
cannot do that for free).

---

## Contents of README

- [Synopsis](#synopsis)
  + [Features](#features)
- [Installation](#installation)
  * [Test/Example Data](#test-example-data)
  * [Deployment](#deployment)
  * [Configuration](#configuration)
    + [Database](#database)
    + [Mail](#mail)
- [User/Admin Documentation](#lengthier-user/admin-documentation)
- [Development](#development)
  * [License](#license)
  * [Contributions](#contributions)
  * [Workflows](#workflows)
    + [Tests](#tests)
    + [i18n](#i18n)
    + [Live reloading of browser sessions](#live-reloading-of-browser-sessions)
    + [Mails and debugging them in_development](#mails-and-debugging-them-in-development)
    + [Releasing](#releasing)
- [Developerish Documentation](#developerish-documentation)
- [And even more todos](#and-even-more-todos)

---

## Synopsis

Project had extremely tight deadlines and is adapted to a single use and
business case as of now. The interface is German (but i18n is fully prepared).

If you want that we host a page for you, need help with a deployment or some
other features, send us a message.

### Features

* Site owner can upload videos assigned to courses and announce appointments.
* Users can register and upon mail confirmation enter a 7-day trial period.
  + within the trial period, users can see the 3 last videos in each course and
    all appointment details.
  + two days before end of trial period, users get informed via a mail that
    trial period (and thus access to videos and appointments) will end soon.
+ Site owner can add subscriptions to users
  + users with subscription can see all videos and all appointments
  + five days before end of subscription, users get informed via a mail that
    subscription (and thus access to videos and appointments) will end soon.
+ Users can contact site owner via a contact form.
+ Site owner can modify certain elements of the page (mini-CMS).
+ Hopefully responsive design everywhere.
+ Scores 99 for desktop and 90 for mobile on googles PageSpeedInsights on our
  deployment!

## Installation

Currently it is assumed that you run Ruby >= 2.6 <= 3 . Then, follow a typical
rails development workflow:

```bash
# git clone / checkout / ...
bundle
rails db:setup
rails s # (development server)
```

### Test / example data

Not very strong yet. Sorry.
Import test/example data with `rails db:fixture:load`.

### Deployment

Not covering all detail here, but also nothing special.

If you need support and have resources, feel free to get in
contact with me. Otherwise follow e.g. herokus or phusion passengers
documentation.

There is a `Procfile` prepared for herokuish/dokku deployments, that will
automigrate the database after push. With it comes a `CHECK` and the respective
rack route to `/up` and a `.buildpacks` file to allow for ffmpeg video previews
(an ActiveStorage feature).


The initial user can be set up like this (run in `rails c` or `rails run`):

```ruby
User.create(email: 'adminsemail', password: 'adminspassword',
  password_confirmation: 'adminspassword', confirmed_at: DateTime.current,
  role: 'admin')
```

To send mails and do other "background-task", you need to start delayed_job. Do
so with `rake jobs:work` .

**Note:** While running `bin/delayed_job run` (or `start`) might also work, you will likely
[see some errors in developement](https://github.com/collectiveidea/delayed_job/issues/1099),
due to usage of Guard (I believe). A half-baked workaround might be to
create `log/delayed_job.log`.

Recurring Jobs (like sending reminders about expiring trial periods and
subscriptions) will be created (if they do not yet exist) if you run
`rails db:migrate`, `rails db:schema:load` or `rails db:schedule_jobs`
(given the `Procfile` here, if you have a deployment respecting
it, you should be safe, due to the defined `release` processe).

To generate the sitemap, either run `rails sitemap:refresh:no_ping` or use a
setup that respects the `Procfile` (the sitemap will be generated in every
worker via `bin/run.sh`).

To update/copy user-provided favicons either run `rails yosis:copy_favicons` or
use a setup that respects the `Procfile` (the favicons will be copied in every
worker via `bin/run.sh`).

### Configuration

#### Database

Set

    DATABASEURL=postgres://aksdjl:aslkalksd@djief:342/aksdu

for production db usage (herokuisih).

#### Mail

To send mails you need to configure your mail credentials. Set following
environment variables:

    HOST=yourhost.comm
    BINDING=yourhost.comm
    MAILER_HOST=yourhost.commm # to generate absolute URLs in mails
    SENDER_EMAIL="Neseri\ Your\ Community\ <registration@yourhost.commm>"
    SMTP_SERVER=smpt.yourhost.commm
    SMTP_DOMAIN=yourhost.commm
    SMTP_PORT=587
    SMTP_PWD=9098asdjlker!
    SMTP_USER=iaowur32oalks
    RAILS_SERVE_STATIC_FILES=yes

#### In-App configuration

Any account with administrator role can edit various SiteSettings from the admin
menu (content, layout, title, ...).

## Lenghtier user/admin documentation

## Development

### License

yosis is copyright 2020 Felix Wolfsteller and released under the
[AGPLv3+](LICENSE).

Some file use [FSFEs reuse software](https://reuse.software/) compliant headers.

This repositories bundles third party assets:

* [app/assets/fonts](app/assets/fonts): The Font **"Source Sans Pro"** from Adobe (https://github.com/adobe-fonts/source-sans-pro), published under the OFL-1.1 . The "black" variant (weight 900) is omitted.

### Contributions

Contributions are more than welcome. For a pleasant experience, mail me or
create issues before you dive deep.

Code is released under the AGPLv3+ (exceptions see below), Copyright 2020 Felix
Wolfsteller. Copyright transfer of contributions is assumed (or get into
contact).

### Workflows

#### Tests

There could be more.

Run tests with `rails t` (you might have to `sudo sysctl fs.inotify.max_user_watches=524288` if you hit filewatch limits with livereloard/guard/spring).

*System tests* have to be run manually with `rails t test/system`.

#### i18n

During development, add new translation keys with

`i18n-tasks add-missing` .

#### Live reloading of browser sessions

With [rack-livereload] and [guard-livereload] you can have your browser
refreshing itself when view files are changed. To do so, before starting your
development server (`rails s`), fire up guard (`guard`) in a separate shell.

#### Mails and debugging them in development

Install mailcatcher (`gem install mailcatcher`), start it and watch mails
arriving at http://127.0.0.1:1080 .

#### Releasing

* Modify version in `config/application.rb` .
* Modify [CHANGELOG.md](CHANGELOG.md) ([https://github.com/olivierlacan/keep-a-changelog/](https://github.com/olivierlacan/keep-a-changelog/))
* Tag the repositories state.
* Push.

## Developerish Documentation

* **Design decisions and resources** are found in the
  [knowledgebase](doc/knowledgebase.md)
* **Some other infos about the tech stack** are found in the
  [knowledgebase](doc/knowledgebase.md), too.

