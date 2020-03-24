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

Non many yet. Sorry.
Run tests with `rails t` (you might have to `sudo sysctl fs.inotify.max_user_watches=524288` if you hit filewatch limits with livereloard/guard/spring).
Import test/example data with `rails db:fixture:load`.

### Deployment

Not covered here, but also nothing special.

If you need support and have resources, feel free to get in
contact with me. Otherwise follow e.g. herokus or phusion passengers
documentation.

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

### Contributions

Contributions are more than welcome. For a pleasant experience, mail me or
create issues before you deep dive.

### Workflows

#### Tests

None yet. shame.

#### i18n

During development, add new translation keys with

`i18n-tasks add-missing` .

#### Live reloading of browser sessions

With [rack-livereload] and [guard-livereload] you can have your browser
refreshing itself when view files are changed. To do so, before starting your
development server (`rails s`), fire up guard (`guard`) in a separate shell.

#### Releasing

* Modify version in `config/application.rb` .
* Tag the repositories state.
* Push.

## Developerish Documentation

* **Design decisions and resources** are found in the
  [knowledgebase](doc/kndowledgebase.md)


## And even more todos

* Database initialization

* Services (job queues, cache servers, search engines, etc.)
