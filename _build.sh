#!/bin/sh

set -ev

#render full version
Rscript -e "bookdown::render_book()"

# # copy robots.txt for live site version
# cp -pr robots.txt site

# # render all the slides
# for file in $( find slides -name "[^_]*.Rmd" -maxdepth 1 ); do
#   Rscript -e "rmarkdown::render('$file')"
# done
