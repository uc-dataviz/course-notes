#!/bin/sh

set -ev

#render full version
Rscript -e "bookdown::render_book(input = 'index.Rmd', output_format = 'bookdown::gitbook', config_file = '_bookdown.yml')"

# # copy robots.txt for live site version
# cp -pr robots.txt site

# # copy data/images folders for live site version
# cp -pr data site
# cp -pr images site

# render all the slides
for file in $( find slides -name "[^_]*.Rmd" -maxdepth 1 ); do
  Rscript -e "rmarkdown::render('$file')"
done
