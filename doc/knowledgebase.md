# Knowledge Base

## Architectural "design" decisions and stuff to know

This project was hacked with a tight time budget and virtually no resources
(besides server space). It couldnt be made clean and lots of tradeoffs had to be
done.

### JavaScript

* Removed webpacker, replaced by sprockets.
* Use the `direct_upload` stuff from ActiveStorage as is (exception: we want to
  see the errors alert).

### SiteSettings

* Global Site Settings implemented by a crude [SiteSettings
  Model](app/model/site_settings). No seed or prepopulation, they are created on
  the fly in the controller. Tradeoffs made

### Storage

Settled on ActiveStorage, also other implementations and services offer some
nifty features like working previews and variants for videos.

## Resources and lessons learned

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
