# Knowledge Base

## Contents

- [1 Tech Stack](#1-tech-stack)
- [2 Architecture](#2-architectural-design-designions-and-stuff-to-know)
  + [2.1 Dokku](#2.1-dokku)
  + [i18n](#i18n)
  + [JavaScript](#javascript)
  + [Sitewide Settings](#sitesettings)
  + [Spam and Security](#spam-and-security)
    * [Tests and ActiveStorage](#tests-and-activestorage)
  + [Background Jobs](#jobs)
    * [Recurring Jobs](#recurring-jobs)
  + [GDPR](#gdpr)
    * [Policy agreements](#policy-agreements)
    * [Rights on data](#rights-on-data)
  + [Access Policies](#policies)
  + [UX](#ux)
- [Resources and lessons learned](#resources-and-lessons-learned)
  + [ActiveStorage](#activestorage)
  + [Big File upload](#big-file-upload)
    * [nginx](#nginx)
  + [Storage backends for videos](#storage-backends-for-videos)
    * [Video Players](#videoplayers)
    * [ffmpeg](#ffmpeg)
  + [Bulma](#bulma)
  + [Fonts](#fonts)
  + [Operations](#operations)
  + [StimulusJS](#stimulusjs)
- [ActiveRecord](#activerecord)
- [Licensing](#licensing)
- [Known optimizabilities](#know-optimizabilities)


## 1 Tech Stack

Mentionable (uncommon or outstanding) pieces of functionality:

* [fontawesome](): popular clean icon font
* [bulma](https://bulma.io): flex-based customizable CSS library
* [ruby]() and [ruby on rails] not-so-popular-anymore programming language and
  web-application framework that are both a joy to work with
* [ahoy_email](): usually for mail-tracking, used for mail archieve
* [friendly_id](): makes pretty URLs (https://mysite/mydrawer/mystuff) pretty
  easy
* [stimulusjs](): organized, well-interweaved front-end code
* [i18n-tasks](): handy tool to inspect your translation coverage
* many really useful gems: yeah, thats a helpful statement

## 2 Architectural "design" decisions and stuff to know

This project was hacked with a tight time budget and virtually no resources
(besides server space). It couldnt be made clean and lots of tradeoffs had to be
done.

### 2.1 Dokku

[Is awesome](http://dokku.viewdocs.io). Its documentation is great, too.
For a brief overview how to use it with a rails app, read e.g.
https://medium.com/@dpaluy/the-ultimate-guide-to-dokku-and-ruby-on-rails-5-9ecad2dba4a3
.

Bottom line: host your own heroku. Deploy using `git push <myserver>`.

### i18n

The translation files ([conf/locales][conf/locales]) are only roughly split in
thematic chunks.

To inspect the translation coverage `i18n-tasks` can be used. There is a
[test case](test/i18n_test.rb) for unused and missing translation keys prepared
that will fire above a threshold.


### JavaScript

Tried to go the least pain route and rely on server-side rendering.
This is a very conservative choice and gamble that developers productivity will
be higher because of a more stable technique (and more experience with the old
stuff).

* Removed webpacker, replaced by sprockets in commit
  #033656121a44b25351afb4943bf4bff0bad90352 .
* Use the `direct_upload` stuff from ActiveStorage as is (exception: we want to
  see the errors alert).
* Also removed everything (or most) yarnish in commit
  #037e4aa90b82791f1a85408d926fc19f6486275e .

However, turbolinks is still active and stimulusjs is used for some "backend"
(admin) sugar.

HTML5 video tag seems to work for now, too (other options: see below).

### SiteSettings

* Global Site Settings implemented by a crude [SiteSettings
  Model](app/model/site_settings). No seed or prepopulation, they are created on
  the fly in the controller. Tradeoffs made. Its model allows for a `kind` and
  attachments. The kind can be `markdown`, so that a html-rendered version is
  stored in the db rather than being rerendered on every page view.
* SiteSetting can be accessed by `SiteSettings.fetch` which will initialize the
  setting with a default value.
* Other site wide settings can be set via environment variables.

#### Markdown

Is used for content like blog posts or text blocks. Rendered via redcarpet.

### Spam and Security

Using `invisible_captcha` on login.
And `Rack::Attack` against password brute-force. Plenty of
room for improvements.

### Storage

Settled on ActiveStorage, also other implementations and services offer some
nifty features like working previews and variants for videos.
However for the local storage scenario its a suboptimal choice (e.g. more
redirects than necessary).

#### Tests and ActiveStorage

Controller and System tests need to have some data to be able to be crunched. I
settled on a single white pixel png. Setting up the fixtures involved adding a
test/fixtures/active_storage/attachment.yml and a
test/fixtures/active_storage/blobs.yml .

Also had to create the key and checksum, see:
https://stackoverflow.com/questions/50453596/activestorage-fixtures-attachments
.

 
### Jobs

DelayedJob does not need a redis setup, which makes it a simpler for
development but only suitable for periodic jobs or database-insensitive apps.
Sidekiq kicks the rests ass, but comes with market.

For production, `worker: rake jobs:work` should do the trick.

DelayedJob has two Web UIs (https://github.com/ejschmitt/delayed_job_web and ... ), but it was simple to roll ones own.
It also has a cron-like addition: https://github.com/codez/delayed_cron_job .

Overview about schedule job runs is provided via
`admin/controllers/delayed_jobs_controller`.

#### Recurring Jobs

There are at least three solutions for recurring jobs:

- use an outside cron job (or other schedule job system) to schedule or
  trigger relevant jobs or job creation
- use [delayed_cron_job](https://github.com/codez/delayed_cron_job) that
  implements a cron-like behaviour for jobs.
- use [delayed_job_recurring](https://github.com/amitree/delayed_job_recurring)
  for recurring jobs
- use something like delayed_cron within Rails: https://github.com/sellect/delayed_cron

`delayed_cron_job` was chosen.

#### Serialization/mail Jobs

In case of the contact form, a tableless `Contact` model instance is created.
In order to save all needed jobs data to the database, passed objects need to be
serialized, where `ActiveModel::Serialization` can help, but is not enough (see the [ActiveJob Guide](https://edgeguides.rubyonrails.org/active_job_basics.html#supported-types-for-arguments))

Now, either you spell out all given parameters, you write a Serializer or you
just pass the params into the job and create the Model-Object within the job at
"run"-time.

I decided to pass the parameters, which seemed to be the least hazzle.

### GDPR

#### Policy agreements

Two separate policies have to be agreed to (technically, one has only to be
taken notice of, there cannot be disagreement by click).

As the policies might change, it is important to store the date of the consents.

In order to force users to agree to the policies (at registration), the
devises User model is adjusted to force acceptance via a checkbox.
This applies only in the create-phase.

The agreement itself is not stored, but is timestamped instead (column:
`accepted_terms_at`). To ease things (and we are only dealing with two
policies), just one timestamp is stored - if the consent becomes invalid
(because outdated), both policies have to be re-agreed to.

After a valid login we have to redirect users to re-agree to the terms/policies
if they are outdated. To do so there are at least two general approaches.

To hook into the devise workflow, a custom registrations_controller is
implemented, that overrides the `sign_up_params`. Futhermore, tableless
attributes are added to the User model and the registration form is adjusted
accordingly.

A separate controller and view allow the current user to agree to the policies.
Users are redirected there if no consent date was found.

#### Rights on data

##### Deletion/anonymisation
Anonymisation will be fine. Make sure to cover the emails as well.


### Access Policies

Go-to successor of CanCan(Can) is [active_policies](https://github.com/palkan/action_policy).

But so far, I just go with POROs (in `lib/policies/`).

### UX

#### Admin: CMS

Administrative users want to be able to look at the home page and edit stuff
without too much admin menu navigation. Thus implemented a simple way to display
modifiyable content and link it to the appropriate "admin" area. This is a WIP
and not yet thought through, neither visually nor from the business logic side.
Sure enough, live editing or modals would be convenient to have for
administrative users.

The admin user will be directed to the form that corresponds to the item that is
to be edited. A special parameter (`back_path`) is set and 'persisted' across
the requests using a parameter. The controller that saves the changes looks for
the parameter and redirects back to that page if present. An optional anchor is
included in the link so that the user is hopefully shown more or less the place
where the change is shown.

#### Admin: Forms

##### Dynamic Associations

For the `Asana Lexicon` a one-to-many form is implemented. This works with
`accepts_nested_attributes_for` and `language_code` scopes.

The form always displays at least one input field set for an `AsnaName`
(`fields_for` on in-form created AsanaName).

In order to add and delete more entries dynamically, a stimulus controller was
implemented
([`association_form_controller`](app/assets/javascripts/controllers/association_form_controller.es6)).

###### Deletion

Simply set the `destroy_fieldTarget.value` to true on button click and use the
`reveal_controller` to hide the element.

###### Addition

Clone a given template form and insert it into the DOM. This works similarly to
a [tutorial on pluralsight](https://www.pluralsight.com/guides/ruby-on-rails-nested-attributes), with a small change: if the sumitted parameters like `asana[asana_names][REPLACE][name]='First Asana'` includes a string instead of an integer index (in the example: REPLACE), the controller will reject the parameters. Thus, the template form parts should not be submitted themselves, which is accomplished by marking them `disabled`.


##### Flow
Try to make the flow left-top to bottom-right. Confirmative action on the right
(page-flipping direction).

##### Markdown
Implemented a simple straightforward markdown preview renderer that renders
manually and server-side. This was done using jummy stimulusJS-controllers.

### Mail archive

For mail "tracking" (saving outgoing mails to ensure that the right mails got
sent), `ahoy_email` is used, with the additional `content` column (somewhat
undocumented feature).

### Mails, generally

E-Mail RFCs are hairy compared to old men. For multipart emails, you can use
`(mail.html_part || mail.text_part || mail).body.decoded` to access the body in
a relatively friendly way.

[The 100% correct way to validate email
addresses](https://medium.com/hackernoon/the-100-correct-way-to-validate-email-addresses-7c4818f24643)
with some statistics and a funny twist.

## Resources and lessons learned

### ActiveRecord

When introducing new validations, old migrations might fail (e.g. if you
validate the presence of an attribute that is only added by a later migration).

There are multiple approaches to this, I had to revert to using plain SQL in 
[db/migrate/20200325204229_add_row_order_to_lessons.rb](db/migrate/20200325204229_add_row_order_to_lessons.rb).

#### Switching database

I had to convert a postgres database to sqlite3, which is relaxingly easy with
the `sequel` gem: `sequel -C postgres://.... sqlite://...`


### ActiveStorage

ActiveStorage might delete your files on form submission in some cases where
you'd prefer to keep them. I think this is more an issue for multiple
attachments, however, I have seen and implemented (cabler) workarounds:
https://github.com/ecovillage/cabler ,
https://stackoverflow.com/questions/56649565/when-using-activestorage-in-rails-6-how-do-i-retain-a-file-when-redisplaying-a
.

* Active Storage does not protect your uploads from access. You will have to
  fiddle with something like 
  https://stackoverflow.com/questions/49808950/secure-active-storage-with-devise
  to improve the situation slightly. 

### Big file upload

* Using ActiveStorage and a local Disk Service poses interesting challenges
* The files to be uploaded will be rather big (videos), thus we want to have
  feedback
* Took the direct_upload stuff from ActiveStorage guide.
* Increased the `service_urls_expire_in` limit to prevent long lasting uploads
  to hit a 404 on the attachment URL.
* It might be worth to check out some Rack configuration (https://github.com/rack/rack/issues/1075)
* Rack timeouts might not be the issue if you do not set them (https://stackoverflow.com/questions/2583166/set-rails-request-timeout-execution-expired, https://github.com/sharpstone/rack-timeout)

#### Nginx

Nginx client_max_body_size is your friend. Others might join,
https://github.com/Chocobozzz/PeerTube/issues/1359, https://serverfault.com/questions/820597/nginx-does-not-serve-large-files

#### Favicon

Favicons are a tiny bit [more nasty](https://en.wikipedia.org/wiki/Favicon)
than tought, but still manageable.

Annoyingly and arrogantly Apple and the other walk their own paths.

I settled on this combo:
  * a `/favicon.ico` 48x48 `x-icon`
  * a `/favicon-32x32.png` 32x32 png
  * a `/apple-touch-icon.png` 180x180 png

These need to be uploaded via SiteSetting. The `yosis:copy_favicon` rake task
takes care of
putting the relevant files in the `public/` folder. The references in the
`<html><head>` is done **without checking for existence**, which might be a
premature optimization, but so what. Just create favicons, and its fine.

`rails yosis:copy_favicons` is automatically called in `bin/run.sh` (which is
the task to run for `web` workers in herokuish dokku deploys).


#### Sitemap

A Sitemap-Controller would be easy to implement, but I chose the
sitemap_generator gem. Challenge here is to have the sitemap generated and
"stored" in a herokuish dokku deployment. For this, [`bin/run.sh`](bin/run.sh) is made the
default `web:` task in the [Procfile](Procfile).


#### Procfile, schema migrations and scheduling jobs

The `release` target in a `Procfile` is shot in a one-off container, which is
okay for db migrations and initial cron schedules, but not for e.g. Sitemap
generation or asset compilation and stuff (which has to happen in the `web` or
`worker` targets).

### Storage backends for videos


### (loosely related) Video codecs and encoding

* Video streaming as of 2020 might require that you fiddle with HTML5 markup,
  videoplayer javascripts and formats and codecs.
* For now, go with plain HTML5 video tag.
* webm and mp4 seems to get your typical audience covered
* Browsers like to have some metadata at the beginning of a file:
  `ffmpeg -i input.file -movflags faststart output.file`
* HLS streaming is advanced
  (https://www.streamingmedia.com/Articles/Editorial/Featured-Articles/How-to-Automate-FFmpeg-and-Bento4-With-Bash-Scripts-129295.aspx?pageNum=2
  , https://docs.peer5.com/guides/production-ready-hls-vod/) and might need more setup on JavaScript / ruby / nginx side. Unclear.

#### Videoplayers

https://videojs.com/ (https://github.com/videojs/video.js) and medialelement (https://github.com/mediaelement/mediaelement) seem to cover stuff (HLS streaming, multiple qualities, frontend, js driven interactions, ...). But there are many
more, like [plyr](https://github.com/sampotts/plyr.)

#### FFmpeg

* ffmpeg supports multiple outputs http://trac.ffmpeg.org/wiki/Creating%20multiple%20outputs
* The ruby wrapper https://github.com/streamio/streamio-ffmpeg seems to be the
  gem to go with.
* The ffmpeg man pages and webpages have some good hints: https://trac.ffmpeg.org/wiki/Encode/H.264, https://trac.ffmpeg.org/wiki/Encode/AAC
* https://trac.ffmpeg.org/wiki/FilteringGuide
* Newest (as of 2020) ffmpeg has some noise removal filters build in: https://superuser.com/questions/733061/reduce-background-noise-and-optimize-the-speech-from-an-audio-clip-using-ffmpeg . They work like this:
  * http://ffmpeg.org/ffmpeg-filters.html#afftdn
    - needs to be "trained" with `sample_noise / sn`
    - https://video.stackexchange.com/questions/29274/how-can-you-use-ffmpegs-afftdn-sn-flag-to-sample-noise-from-a-reference-noise?newreg=cbccf0cb2e914fc7b0e668eb33764794
  * http://ffmpeg.org/ffmpeg-filters.html#anlmdn
* Other noise reduction filters:
  * http://ffmpeg.org/ffmpeg-filters.html#arnndn (neural network, needs training
    model)
* via ladspa: https://github.com/werman/noise-suppression-for-voice/issues/11

### Bulma

Nice and mostly responsive (be careful with `levels` and `media` elements).
Custom color-types and shades could be implemented:
https://github.com/jgthms/bulma/issues/2244 (undocumented), https://bulma.io/2019/10/15/light-dark-colors/






### Operations

#### Spam detection

To secure operations against attacks or weird clients, one line of defense is
within the application. There, two approaches are prepared:

* form submission (simple captcha) with [InvisibleCaptcha](https://github.com/markets/invisible_captcha) (alternative to checkout might be [HoneypotCaptcha](https://github.com/curtis/honeypot-captcha))
* general flooding protection using [Rack::Attack]()

### StimulusJS

While Rails 6 and stimulusjs via sprockets might seem like an odd idea, it works
pretty well with a workaround (to transpile es6 to es5): include babel and do
not name your js files \*.js but \*.es6 .

#### Database switching

I had to convert a postgres database to sqlite3, which is relaxingly easy with
the `sequel` gem: `sequel -C postgres://.... sqlite://...`

## ActiveRecord

Scoped not exists (e.g. User#in_trial :-> has no Subscription#current) might be
implemented like this:
https://medium.com/rubyinside/active-records-queries-tricks-2546181a98dd (Trick
3) or with left_outer_joins? (https://stackoverflow.com/questions/10355002/rails-scope-to-check-if-association-does-not-exist)

## Licensing

SPDX License header for (FSFEs) [reuse compliance](https://reuse.software/) were
added to some generated files, too, attributing Felix Wolfsteller Copyright and
the chosen license which might differ from the license of the original
"generator". There is differing opinions to whether or
not to do this, but most voices that I read were in favor of doing so. If you
happen to disagree, it would be easy to change the relevant files with the
correct header.

## Known optimizabilities

I'm glad if somebody helps out. The current setup arrives at a 99% desktop
performance on google pagespeed insight, so its fine, but once it scales,
optimizations might become necessary.

+ ActiveRecord generally is not being used up to its shinyness (find_eachs, scope
definitions, joins, includes, N+1 queries, ...).
+ Caching can be implemented/improved
+ ActiveStorages local disk service and the service_urls, expiration stuff seems
  odd and would need investigation. It might just be an odd pick for this
scenario (especially look at things like the Logo which is user provided and
will not change). Also, how will that work in combination with any fragment
caching? We might have to patch ActiveStorage LocalBackend for optimizations.


