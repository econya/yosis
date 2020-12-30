# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://%s" % (ENV['MAILER_HOST'] || 'yosis')

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end


  # Rather static stuff
  #add about_us_path,    lastmod: SiteSetting.find_by_key('about_us').updated_at
  add explanation_path, lastmod: SiteSetting.find_by_key('explanation').updated_at
  add privacy_path,     lastmod: SiteSetting.find_by_key('privacy_statement').updated_at
  add impressum_path,   lastmod: SiteSetting.find_by_key('impressum').updated_at
  add terms_path,       lastmod: SiteSetting.find_by_key('terms').updated_at
  add seminars_path,    lastmod: SiteSetting.find_by_key('seminars_text').updated_at

  # Asana Lexicon
  add asana_lexicon_path, lastmod: Asana.maximum(:updated_at)

  # Blog stuff
  add blog_posts_path, lastmod: Blog::Post.published.maximum(:updated_at)
  Blog::Post.published.find_each do |blog_post|
    add blog_post_path(blog_post),
      lastmod: blog_post.updated_at
  end

  # Place stuff
  #Place.find_each do |place|
  #  add place_path(place), lastmod: place.updated_at
  #end

  # Style stuff
  Style.active.each do |style|
    # TODO include its lessons/videos
    add style_path(style), lastmod: style.updated_at
  end

end
