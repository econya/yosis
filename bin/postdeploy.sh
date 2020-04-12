#!/bin/sh

rails db:migrate
rails sitemap:refresh:no_ping
