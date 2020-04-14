# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

namespace :yosis do
  desc 'Copy favicons to public/'
  task copy_favicons: :environment do
    favicon_setting = SiteSetting.find_by_key('favicon')
    if (img = favicon_setting&.image)&.attached?
      img_path = ActiveStorage::Blob.service.send(:path_for, img.key)
      cp img_path, "public/favicon.ico"
    else
      STDERR.puts "No image attached to favicon(.ico)"
    end

    favicon_setting = SiteSetting.find_by_key('favicon-png')
    if (img = favicon_setting&.image)&.attached?
      img_path = ActiveStorage::Blob.service.send(:path_for, img.key)
      cp img_path, "public/favicon-32x32.png"
    else
      STDERR.puts "No image attached to favicon(.png)"
    end

    favicon_setting = SiteSetting.find_by_key('favicon-apple-touch')
    if (img = favicon_setting&.image)&.attached?
      img_path = ActiveStorage::Blob.service.send(:path_for, img.key)
      cp img_path, "public/apple-touch-icon.png"
      cp img_path, "public/apple-touch-icon-precomposed.png"
    else
      STDERR.puts "No image attached to favicon(apple-touch-icon.png)"
    end
  end
end
