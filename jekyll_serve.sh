#!/usr/bin/env bash
# Preview the site at http://127.0.0.1:4000/ (live reload included).
#
# Uses Docker's default bridge network instead of --net=host: on this network
# IPv6 is broken, and with host networking Bundler tries rubygems.org over IPv6
# first and times out. Gems are cached in the "jekyll-bundle" volume, so only
# the first run is slow.
set -euo pipefail
cd "$(dirname "$0")"

exec docker run --rm $( [ -t 0 ] && echo -it ) \
  --name impactlab-jekyll \
  -p 4000:4000 -p 35729:35729 \
  -v "$PWD":/site \
  -v jekyll-bundle:/usr/local/bundle \
  --entrypoint sh \
  bretfisher/jekyll:latest \
  -c 'cd /site && bundle install --quiet && bundle exec jekyll serve --host 0.0.0.0 --livereload --force_polling'
