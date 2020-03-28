# Yosis video and course platform

yosis is a Ruby on Rails6 Web application to manage (online-) yoga courses and
Free and Open Software, released under the AGPLv3+, copyright Felix Wolfsteller.

## Synopsis

Project had extremely tight deadlines and is totally adapted to a single use and
business case as of now. And German interface (but i18n fully prepared).

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

Not covered here, but also nothing special.

If you need support and have resources, feel free to get in
contact with me. Otherwise follow e.g. herokus or phusion passengers
documentation.

There is a `Procfile` prepared for herokuish/dokku deployments, that will
automigrate the database after push. With it comes a `CHECK` and the respective
rack route to `/up` and a `.buildpacks` file to allow for ffmpeg video previews
(an ActiveStorage feature).

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


## Lenghtier user/admin documentation

## Development

### License

yosis is copyright 2020 Felix Wolfsteller and released under the
[AGPLv3+](LICENSE).

Some file use [https://reuse.software](FSFEs reuse software) compliant headers.

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
* Tag the repositories state.
* Push.

## Developerish Documentation

* **Design decisions and resources** are found in the
  [knowledgebase](doc/kndowledgebase.md)
* **Some other infos about the tech stack** are found in the
  [knowledgebase](doc/kndowledgebase.md), too.

## And even more todos

* Services (job queues, cache servers, search engines, etc.)
