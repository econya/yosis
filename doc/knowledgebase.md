# Knowledge Base

## Architectural "design" decisions and stuff to know

This project was hacked with a tight time budget and virtually no resources
(besides server space). It couldnt be made clean and lots of tradeoffs had to be
done.

### Dokku

[Is awesome](http://dokku.viewdocs.io). Its doku is great, too. For a brief overview, how to use it with
rails, read e.g.
https://medium.com/@dpaluy/the-ultimate-guide-to-dokku-and-ruby-on-rails-5-9ecad2dba4a3
.

### JavaScript

* Removed webpacker, replaced by sprockets in commit
  #033656121a44b25351afb4943bf4bff0bad90352 .
* Use the `direct_upload` stuff from ActiveStorage as is (exception: we want to
  see the errors alert).
* Also removed everything (or most) yarnish in commit
  #037e4aa90b82791f1a85408d926fc19f6486275e .

HTML5 video tag seems to work for now, too (other options: see below)

### SiteSettings

* Global Site Settings implemented by a crude [SiteSettings
  Model](app/model/site_settings). No seed or prepopulation, they are created on
  the fly in the controller. Tradeoffs made

### Spam and Security

Using `invisible_captcha` on login.
And `Rack::Attack` against password brute-force. I know that there is plenty of
room for improvements.

### Storage

Settled on ActiveStorage, also other implementations and services offer some
nifty features like working previews and variants for videos.

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

### Mail archive

For mail "tracking" (saving outgoing mails to ensure that the right mails got
sent), `ahoy_email` is used, with the additional `content` column (somewhat
undocumented feature).

## Resources and lessons learned

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
+ Caching can be improved
+ ActiveStorages local disk service and the service_urls, expiration stuff seems
  odd and would need investigation. It might just be an odd pick for this
scenario (especially look at things like the Logo which is user provided and
will not change). Also, how will that work in combination with any fragment
caching? We might have to patch ActiveStorage LocalBackend for optimizations.


