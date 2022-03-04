# Making plots pretty and clean {#science-polish}




```r
library(tidyverse)
library(ggthemes)
library(knitr)
library(broom)
library(stringr)
library(socviz)
library(patchwork)
library(RColorBrewer)
library(colorspace)
library(dichromat)
library(ggrepel)
library(ggthemes)
library(scales)
library(gapminder)
library(here)
```

## Learning objectives {-}

### Morning

* Define Tufte's theory of data graphics, data-ink ratio, and chartjunk
* Present and compare examples of minimalistic graphics to their original form
* Assess visualizations under the engineer/designers philosophy

### Afternoon

* Demonstrate methods for visualizing uncertainty
* Generate layered plots to highlight specific attributes of data
* Adjust themes

## Assigned readings {-}

* Chapter 8, @healy2018data - accessible via the [book's website](https://socviz.co/)

## Tufte's world

* Core purpose of visualization is to communicate quantitative information
    * Art is secondary
    * "Above all else show the data"
* Goal is to maximize the data-ink ratio

    $$\text{Data-ink ratio} = \frac{\text{data-ink}}{\text{total ink used to print the graphic}}$$

* **Data-ink** - non-erasable core of a graphic
    * This is what Tufte says we should most care about
    * Minimize all extraneous fluff
* What should we consider to be part of the "data-ink"?
    * Is this literally just the data? Don't we need gridlines or axes? What else can be considered integral to the graph?
* He never offers proof of his hypothesis that less is better

### What is integral?

<img src="03-scientific-results-polish_files/figure-html/integral-1.png" width="80%" style="display: block; margin: auto;" />

* Data points
* Axis ticks
* Axis tick labels
* Axis labels
* Background
* Grid lines

What happens if we strip away everything except the data?

<img src="03-scientific-results-polish_files/figure-html/integral-void-1.png" width="80%" style="display: block; margin: auto;" />

Hmm, so what do we actually need to keep? What should we consider "integral"? What if we remove the background color?

<img src="03-scientific-results-polish_files/figure-html/integral-background-1.png" width="80%" style="display: block; margin: auto;" />

* Remove panel box

<img src="03-scientific-results-polish_files/figure-html/integral-panelbox-1.png" width="80%" style="display: block; margin: auto;" />

* Remove minor grid lines

<img src="03-scientific-results-polish_files/figure-html/integral-minor-1.png" width="80%" style="display: block; margin: auto;" />

* Remove all grid lines

<img src="03-scientific-results-polish_files/figure-html/integral-major-1.png" width="80%" style="display: block; margin: auto;" />

* Remove tick marks

<img src="03-scientific-results-polish_files/figure-html/integral-tick-1.png" width="80%" style="display: block; margin: auto;" />

* Use serif font

<img src="03-scientific-results-polish_files/figure-html/integral-serif-1.png" width="80%" style="display: block; margin: auto;" />

What have we lost? Is this easier to interpret? Harder?

## Chart junk

<img src="/Users/soltoffbc/Projects/Data Visualization/course-notes/images/monster-costs.png" width="80%" style="display: block; margin: auto;" />

<img src="/Users/soltoffbc/Projects/Data Visualization/course-notes/images/mcdonalds.jpeg" width="80%" style="display: block; margin: auto;" />

<img src="/Users/soltoffbc/Projects/Data Visualization/course-notes/images/3d-ribbon-chart.jpeg" width="80%" style="display: block; margin: auto;" />

<img src="/Users/soltoffbc/Projects/Data Visualization/course-notes/images/wasted-space.jpeg" width="80%" style="display: block; margin: auto;" />

* Vibrating moire effects
    * Hard to produce in `ggplot2` - no support for them
    * Eye junk
    * Makes the graph harder to decode/interpret
* The grid
    * Minimize/reduce the thickness of grid lines to ease interpretation
    * Less visual clutter to weed through
    * Add some compare/contrast with `ggplot`
* The duck

* Tufte concludes that forgoing chartjunk enables functionality and insight (as Cairo would describe it). Do you agree?

## Compare Tufte minimal graphs to traditional graphs using `ggplot2`

* [`ggthemes`](https://github.com/jrnold/ggthemes)
* Compare other themes for the same basic plot^[Source for examples: [Tufte in R](http://motioninsocial.com/tufte/)]

The goal of Tufte's minimalism is to maximize the data-ink ratio, so we want to modify traditional or default graphs in R and `ggplot2` to minimize use of extraneous ink.

### Minimal line plot

<img src="03-scientific-results-polish_files/figure-html/line-1.png" width="80%" style="display: block; margin: auto;" />

* We use `geom_point()` to draw the data points and `geom_line()` to connect the points
* What is the extraneous ink on this graph?
    * Background
    * Title of graph and y-axis labels - redundant
    * x-axis label - year is obvious/self-explanatory
* Missing context - how is this expansion meaningful over time?

<img src="03-scientific-results-polish_files/figure-html/minline-1.png" width="80%" style="display: block; margin: auto;" />

* Remove axis and graph titles
* Adds text annotation within graph
* Highlights a 5% increase in per capital expandures
* Changes font to be more aesthetically pleasing, not so blockish

### Minimal boxplot

<img src="03-scientific-results-polish_files/figure-html/boxplot-1.png" width="80%" style="display: block; margin: auto;" />

* Key features of a boxplot
    * Lines to indicate:
        * Maximum of IQR
        * 3rd quartile
        * Median
        * 1st quartile
        * Minimum of IQR
    * Dots for outliers
* How many different line strokes do we use?
    * 8 for each graph
    * $8 \times 22 = 176$
* This is extraneous ink

<img src="03-scientific-results-polish_files/figure-html/minboxplot-1.png" width="80%" style="display: block; margin: auto;" />

* Now we use only 22 verticals to show the same data. It could easily be drawn by hand with a single vertical for each category on the x-axis
* Doesn't show outlier info, but is this really necessary?
* Also removes the background color and gridlines

<img src="03-scientific-results-polish_files/figure-html/offset-boxplot-1.png" width="80%" style="display: block; margin: auto;" />

* Here we use offsetting lines to indicate the middle half of the data rather than using a gap
* Is this prettier? Easier to interpret?

### Minimal barchart

<img src="03-scientific-results-polish_files/figure-html/bar-1.png" width="80%" style="display: block; margin: auto;" />

* Again, the background is the main culprit

<img src="03-scientific-results-polish_files/figure-html/minbar-1.png" width="80%" style="display: block; margin: auto;" />

* Erases the box/grid background
* Removes vertical axis
* Use a **white grid** to show coordinate lines through the absence of ink, rather than adding ink
    * Allows us to remove tick marks as well

### Range-frame scatterplot

* A standard bivariate scatterplot

<img src="03-scientific-results-polish_files/figure-html/scatterplot-1.png" width="80%" style="display: block; margin: auto;" />

* Use the frame/axis lines of the graph to communicate important information
    * Extends only to minimum/maximum values in the data, rather than arbitrary points
    * Explicitly identifies the minimum and maximum values

<img src="03-scientific-results-polish_files/figure-html/range-frame-1.png" width="80%" style="display: block; margin: auto;" />

#### With a quartile plot

<img src="03-scientific-results-polish_files/figure-html/range-frame-quartile-1.png" width="80%" style="display: block; margin: auto;" />

* Combine with info on the quartiles of the data to show case this info as well
* Thicker bar indicates inner two quartiles
* Median is explicitly labeled

## Reconsidering Tufte

### When is redundancy better?

<div class="figure" style="text-align: center">
<img src="https://dougmccune.com/blog/wp-content/uploads/2011/04/burglary1.png" alt="Double-time bar chart of crime in the city of San Francisco, 2009-10. Source: [Visualizing Time with the Double-Time Bar Chart](https://dougmccune.com/blog/2011/04/26/visualizing-time-with-the-double-time-bar-chart/)" width="80%" />
<p class="caption">(\#fig:double-bar-chart)Double-time bar chart of crime in the city of San Francisco, 2009-10. Source: [Visualizing Time with the Double-Time Bar Chart](https://dougmccune.com/blog/2011/04/26/visualizing-time-with-the-double-time-bar-chart/)</p>
</div>
    
* Each set of 24 bars show the same data. The top bars run from midnight to 11pm. The bottom bars run from noon to 11am.
* Highlighted regions represent 6-5 (6am-5pm; 6pm-5am)
* Colors represent (roughly) day and night (yellow for day, blue for night)
* Enables representing trends over a 24 hour period without breaking arbitrarily at midnight

<div class="figure" style="text-align: center">
<img src="https://dougmccune.com/blog/wp-content/uploads/2011/04/small_multiples_small.png" alt="Double-time bar chart of crime in the city of San Francisco, 2009-10. Source: [Visualizing Time with the Double-Time Bar Chart](https://dougmccune.com/blog/2011/04/26/visualizing-time-with-the-double-time-bar-chart/)" width="80%" />
<p class="caption">(\#fig:double-bar-chart-facet)Double-time bar chart of crime in the city of San Francisco, 2009-10. Source: [Visualizing Time with the Double-Time Bar Chart](https://dougmccune.com/blog/2011/04/26/visualizing-time-with-the-double-time-bar-chart/)</p>
</div>

* The second graph is incredibly redundant, but which is easier to interpret?
    * Does it pass Tufte's test?
    * What does it mean to be "integral"?

### Does minimalism really help here?

* Accompanying an article declaring that student progress on NAEP tests has come to a virtual standstill

<div class="figure" style="text-align: center">
<img src="https://junkcharts.typepad.com/.a/6a00d8341e992c53ef01b7c8b60cd9970b-pi" alt="Chart from Harvard magazine. Source: [Involuntary head-shaking is probably not an intended consequence of data visualization](https://junkcharts.typepad.com/junk_charts/2016/11/involuntary-head-shaking-is-probably-not-an-intended-consequence-of-data-visualization.html)" width="80%" />
<p class="caption">(\#fig:naep-junk)Chart from Harvard magazine. Source: [Involuntary head-shaking is probably not an intended consequence of data visualization](https://junkcharts.typepad.com/junk_charts/2016/11/involuntary-head-shaking-is-probably-not-an-intended-consequence-of-data-visualization.html)</p>
</div>

* What is the comparison we should make?
* Is this too much color?
* Meets Tufte's minimalist standards, probably has a decent data-ink ratio
* Note Grade 4 math scores for whites in 2009-2015 - does this mean no progress or unknown scores?

<div class="figure" style="text-align: center">
<img src="https://junkcharts.typepad.com/.a/6a00d8341e992c53ef01b8d23fe1c7970c-pi" alt="Redesigned chart from Harvard magazine. Source: [Involuntary head-shaking is probably not an intended consequence of data visualization](https://junkcharts.typepad.com/junk_charts/2016/11/involuntary-head-shaking-is-probably-not-an-intended-consequence-of-data-visualization.html)" width="80%" />
<p class="caption">(\#fig:naep-redesign)Redesigned chart from Harvard magazine. Source: [Involuntary head-shaking is probably not an intended consequence of data visualization](https://junkcharts.typepad.com/junk_charts/2016/11/involuntary-head-shaking-is-probably-not-an-intended-consequence-of-data-visualization.html)</p>
</div>

* This version is much clearer - specifically tells us how to compare the scores
* Removes color as a channel, using linetype instead
    * In this situation, is that better or worse?
* Title for the graph makes clear the point trying to be made

### Experimental tests of Tufte's claims

* How do we know Tufte's claims are true? We can test them with experiments!

<div class="figure" style="text-align: center">
<img src="/Users/soltoffbc/Projects/Data Visualization/course-notes/images/tufte_experiment.png" alt="Source: Figure 2 from [Bateman, Scott, et al. &quot;Useful junk?: the effects of visual embellishment on comprehension and memorability of charts.&quot; *Proceedings of the SIGCHI Conference on Human Factors in Computing Systems*. ACM, 2010.](http://www.cedma-europe.org/newsletter%20articles/misc/The%20Effects%20of%20Visual%20Embellishment%20on%20Comprehension%20and%20Memorability%20of%20Charts.pdf)" width="80%" />
<p class="caption">(\#fig:tufte-experiment)Source: Figure 2 from [Bateman, Scott, et al. "Useful junk?: the effects of visual embellishment on comprehension and memorability of charts." *Proceedings of the SIGCHI Conference on Human Factors in Computing Systems*. ACM, 2010.](http://www.cedma-europe.org/newsletter%20articles/misc/The%20Effects%20of%20Visual%20Embellishment%20on%20Comprehension%20and%20Memorability%20of%20Charts.pdf)</p>
</div>

#### Protocol

* Compared chartjunk versions of graphs to standard/minimalist versions of graphs
* Tested individuals on chart description and recall
* 20 subjects split into short and long-term recall groups
    * Quite a small sample of convenience (university population)
* Collected measures
    * Response scores - did the individual correctly read/interpret the chart?
    * Preferences - which type of chart did the individual prefer? Standard or embellished?
    * Gaze data - where did the subject look during the experiment? At data regions or embellishment regions?

#### Results

<div class="figure" style="text-align: center">
<img src="/Users/soltoffbc/Projects/Data Visualization/course-notes/images/tufte_experiment_results.png" alt="Source: Figures 4-6 from [Bateman, Scott, et al. &quot;Useful junk?: the effects of visual embellishment on comprehension and memorability of charts.&quot; *Proceedings of the SIGCHI Conference on Human Factors in Computing Systems*. ACM, 2010.](http://www.cedma-europe.org/newsletter%20articles/misc/The%20Effects%20of%20Visual%20Embellishment%20on%20Comprehension%20and%20Memorability%20of%20Charts.pdf)" width="80%" />
<p class="caption">(\#fig:tufte-experiment-results)Source: Figures 4-6 from [Bateman, Scott, et al. "Useful junk?: the effects of visual embellishment on comprehension and memorability of charts." *Proceedings of the SIGCHI Conference on Human Factors in Computing Systems*. ACM, 2010.](http://www.cedma-europe.org/newsletter%20articles/misc/The%20Effects%20of%20Visual%20Embellishment%20on%20Comprehension%20and%20Memorability%20of%20Charts.pdf)</p>
</div>

* No difference for description
* No difference for immediate recall
* Embellished images slightly better for long-term recall (12-22 days after treatment)

### Discussing the results

* Why did the chartjunk not lead to worse description and recall?
    * Chartjunk was related to the topic of the chart
    * "Gets to the point quicker"
* Why would the embellished images produce better long-term recall?
    * Very vivid image
    * Value message - individual believes author is trying to communicate a set of values
    * Embellished images produced more value messages
* Should visualizations be "objective"?
    * Tufte seems to think so: minimalism leads to the data speaking for itself - do we buy this?

### Rethinking Tufte's definition of visual excellence

* Too many of Tufte's claims are based on nothing - no evidence to support his minimalistic approach to graphical design
* Think of the hockey stick chart vs. xkcd on Earth's temperature
    * According to Tufte, both probably have a lot of chartjunk (xkcd more so)
    * But if asked to remember the importance and story of the graph weeks later, which one do you think the average reader would recall better?
    
### Testing this theory

* Design an experiment to test the impact/effectiveness of chartjunk vs. minimalism
* What protocols/features could we use? How could we deploy the experiment?
    * If deployed on a platform such as Amazon MTurk, what are the benefits and drawbacks?

## Visualizing uncertainty



\BeginKnitrBlock{rmdnote}<div class="rmdnote">Download the necessary data files for the following coding exercises using `usethis::use_course("css-data-mining-viz/science-polish")`.
</div>\EndKnitrBlock{rmdnote}

For this example, we're going to use historical weather data from [Dark Sky](https://darksky.net/forecast/33.7546,-84.39/us12/en) about wind speed and temperature trends for downtown Atlanta ([specifically `33.754557, -84.390009`](https://www.google.com/maps/place/33°45'16.4"N+84°23'24.0"W/@33.754557,-84.3921977,17z/)) in 2019. I downloaded this data using Dark Sky's (about-to-be-retired-because-they-were-bought-by-Apple) API using the [ **darksky** package](https://github.com/hrbrmstr/darksky).

- [`atl-weather-2019.csv`](/data/atl-weather-2019.csv)

### Load and clean data

First, we load the libraries we'll be using:


```r
library(tidyverse)
library(lubridate)
library(ggridges)
library(gghalves)
```

Then we load the data with `read_csv()`. Here I assume that the CSV file lives in a subfolder in my project named `data`:


```r
weather_atl_raw <- read_csv("data/atl-weather-2019.csv")
```



We'll add a couple columns that we can use for faceting and filling using the `month()` and `wday()` functions from **lubridate** for extracting parts of the date:


```r
weather_atl <- weather_atl_raw %>% 
  mutate(Month = month(time, label = TRUE, abbr = FALSE),
         Day = wday(time, label = TRUE, abbr = FALSE))
```

Now we're ready to go!

### Histograms

We can first make a histogram of wind speed. We'll use a bin width of 1 and color the edges of the bars white:


```r
ggplot(weather_atl, aes(x = windSpeed)) +
  geom_histogram(binwidth = 1, color = "white")
```

<img src="03-scientific-results-polish_files/figure-html/basic-histogram-1.png" width="80%" style="display: block; margin: auto;" />

This is fine enough, but we can improve it by forcing the buckets/bins to start at whole numbers instead of containing ranges like 2.5–3.5. We'll use the `boundary` argument for that. We also add `scale_x_continuous()` to add our own x-axis breaks instead of having things like 2.5, 5, and 7.5:


```r
ggplot(weather_atl, aes(x = windSpeed)) +
  geom_histogram(binwidth = 1, color = "white", boundary = 1) +
  scale_x_continuous(breaks = seq(0, 12, by = 1))
```

<img src="03-scientific-results-polish_files/figure-html/basic-histogram-better-1.png" width="80%" style="display: block; margin: auto;" />

We can show the distribution of wind speed by month if we map the `Month` column we made onto the fill aesthetic:


```r
ggplot(weather_atl, aes(x = windSpeed, fill = Month)) +
  geom_histogram(binwidth = 1, color = "white", boundary = 1) +
  scale_x_continuous(breaks = seq(0, 12, by = 1))
```

<img src="03-scientific-results-polish_files/figure-html/histogram-by-month-1.png" width="80%" style="display: block; margin: auto;" />

This is colorful, but it's impossible to actually interpret. Instead of only filling, we'll also facet by month to see separate graphs for each month. We can turn off the fill legend because it's now redundant.


```r
ggplot(weather_atl, aes(x = windSpeed, fill = Month)) +
  geom_histogram(binwidth = 1, color = "white", boundary = 1) +
  scale_x_continuous(breaks = seq(0, 12, by = 1)) + 
  guides(fill = FALSE) +
  facet_wrap(vars(Month))
```

<img src="03-scientific-results-polish_files/figure-html/histogram-by-month-facet-1.png" width="80%" style="display: block; margin: auto;" />

Neat! January, March, and April appear to have the most variation in windy days, with a few wind-less days and a few very-windy days, while August was very wind-less.

### Density plots

The code to create a density plot is nearly identical to what we used for the histogram—the only thing we change is the `geom` layer:


```r
ggplot(weather_atl, aes(x = windSpeed)) +
  geom_density(color = "grey20", fill = "grey50")
```

<img src="03-scientific-results-polish_files/figure-html/basic-density-1.png" width="80%" style="display: block; margin: auto;" />

If we want, we can mess with some of the calculus options like the kernel and bandwidth:


```r
ggplot(weather_atl, aes(x = windSpeed)) +
  geom_density(color = "grey20", fill = "grey50",
               bw = 0.1, kernel = "epanechnikov")
```

<img src="03-scientific-results-polish_files/figure-html/density-kernel-bw-1.png" width="80%" style="display: block; margin: auto;" />

We can also fill by month. We'll make the different layers 50% transparent so we can kind of see through the whole stack:


```r
ggplot(weather_atl, aes(x = windSpeed, fill = Month)) +
  geom_density(alpha = 0.5)
```

<img src="03-scientific-results-polish_files/figure-html/density-fill-by-month-1.png" width="80%" style="display: block; margin: auto;" />

Even with the transparency, this is really hard to interpret. We can fix this by faceting, like we did with the histograms:


```r
ggplot(weather_atl, aes(x = windSpeed, fill = Month)) +
  geom_density(alpha = 0.5) +
  guides(fill = FALSE) +
  facet_wrap(vars(Month))
```

<img src="03-scientific-results-polish_files/figure-html/density-facet-by-month-1.png" width="80%" style="display: block; margin: auto;" />

Or we can stack the density plots behind each other with [**ggridges**](https://cran.r-project.org/web/packages/ggridges/vignettes/introduction.html). For that to work, we also need to map `Month` to the y-axis. We can reverse the y-axis so that January is at the top if we use the `fct_rev()` function:


```r
ggplot(weather_atl, aes(x = windSpeed, y = fct_rev(Month), fill = Month)) +
  geom_density_ridges() +
  guides(fill = FALSE)
```

<img src="03-scientific-results-polish_files/figure-html/ggridges-basic-1.png" width="80%" style="display: block; margin: auto;" />

We can add some extra information to `geom_density_ridges()` with some other arguments like `quantile_lines`. We can use the `quantiles` argument to tell the plow how many parts to be cut into. Since we just want to show the median, we'll set that to 2 so each density plot is divided in half:


```r
ggplot(weather_atl, aes(x = windSpeed, y = fct_rev(Month), fill = Month)) +
  geom_density_ridges(quantile_lines = TRUE, quantiles = 2) +
  guides(fill = FALSE)
```

<img src="03-scientific-results-polish_files/figure-html/ggridges-quantile-1.png" width="80%" style="display: block; margin: auto;" />

Now that we have good working code, we can easily substitute in other variables by changing the x mapping:


```r
ggplot(weather_atl, aes(x = temperatureHigh, y = fct_rev(Month), fill = Month)) +
  geom_density_ridges(quantile_lines = TRUE, quantiles = 2) +
  guides(fill = FALSE)
```

<img src="03-scientific-results-polish_files/figure-html/ggridges-quantile-temp-1.png" width="80%" style="display: block; margin: auto;" />

We can get extra fancy if we fill by temperature instead of filling by month. To get this to work, we need to use `geom_density_ridges_gradient()`, and we need to change the `fill` mapping to the strange looking `..x..`, which is a weird ggplot trick that tells it to use the variable we mapped to the x-axis. For whatever reason, `fill = temperatureHigh` doesn't work 🤷:


```r
ggplot(weather_atl, aes(x = temperatureHigh, y = fct_rev(Month), fill = ..x..)) +
  geom_density_ridges_gradient(quantile_lines = TRUE, quantiles = 2) +
  scale_fill_viridis_c(option = "plasma") +
  labs(x = "High temperature", y = NULL, color = "Temp")
```

<img src="03-scientific-results-polish_files/figure-html/ggridges-gradient-temp-1.png" width="80%" style="display: block; margin: auto;" />

And finally, we can get *extra* fancy and show the distributions for both the high and low temperatures each month. To make this work, we need to manipulate the data a little. Right now there are two columns for high and low temperature: `temperatureLow` and `temperatureHigh`. To be able to map temperature to the x-axis and high vs. low to another aesthetic (like `linetype`), we need a column with the temperature and a column with an indicator variable for whether it is high or low. This data needs to be tidied (since right now we have a variable (high/low) encoded in the column name). We can tidy this data using `pivot_longer()` from **tidyr**, which was already loaded with `library(tidyverse)`. In the RStudio primers, you did this same thing with `gather()`—`pivot_longer()` is the newer version of `gather()`:


```r
weather_atl_long <- weather_atl %>% 
  pivot_longer(cols = c(temperatureLow, temperatureHigh),
               names_to = "temp_type",
               values_to = "temp") %>% 
  # Clean up the new temp_type column so that "temperatureHigh" becomes "High", etc.
  mutate(temp_type = recode(temp_type, 
                            temperatureHigh = "High",
                            temperatureLow = "Low")) %>% 
  # This is optional—just select a handful of columns
  select(time, temp_type, temp, Month) 

# Show the first few rows
head(weather_atl_long)
## # A tibble: 6 × 4
##   time                temp_type  temp Month  
##   <dttm>              <chr>     <dbl> <ord>  
## 1 2019-01-01 05:00:00 Low        50.6 January
## 2 2019-01-01 05:00:00 High       63.9 January
## 3 2019-01-02 05:00:00 Low        49.0 January
## 4 2019-01-02 05:00:00 High       57.4 January
## 5 2019-01-03 05:00:00 Low        53.1 January
## 6 2019-01-03 05:00:00 High       55.3 January
```

Now we have a column for the temperature (`temp`) and a column indicating if it is high or low (`temp_type`). The dataset is also twice as long (730 rows) because each day has two rows (high and low). Let's plot it and map high/low to the `linetype` aesthetic to show high/low in the border of the plots:


```r
ggplot(weather_atl_long, aes(x = temp, y = fct_rev(Month), 
                             fill = ..x.., linetype = temp_type)) +
  geom_density_ridges_gradient(quantile_lines = TRUE, quantiles = 2) +
  scale_fill_viridis_c(option = "plasma") +
  labs(x = "High temperature", y = NULL, color = "Temp")
```

<img src="03-scientific-results-polish_files/figure-html/ggridges-gradient-temp-high-low-1.png" width="80%" style="display: block; margin: auto;" />

Super neat! We can see much wider temperature disparities during the summer, with large gaps between high and low, and relatively equal high/low temperatures during the winter.

### Box, violin, and rain cloud plots

Finally, we can look at the distribution of variables with box plots, violin plots, and other similar graphs. First, we'll make a box plot of windspeed, filled by the `Day` variable we made indicating weekday:


```r
ggplot(weather_atl,
       aes(y = windSpeed, fill = Day)) +
  geom_boxplot()
```

<img src="03-scientific-results-polish_files/figure-html/basic-boxplot-1.png" width="80%" style="display: block; margin: auto;" />

We can switch this to a violin plot by just changing the `geom` layer and mapping `Day` to the x-axis:


```r
ggplot(weather_atl,
       aes(y = windSpeed, x = Day, fill = Day)) +
  geom_violin()
```

<img src="03-scientific-results-polish_files/figure-html/basic-violin-1.png" width="80%" style="display: block; margin: auto;" />

With violin plots it's typically good to overlay other geoms. We can add some jittered points for a strip plot:


```r
ggplot(weather_atl,
       aes(y = windSpeed, x = Day, fill = Day)) +
  geom_violin() +
  geom_point(size = 0.5, position = position_jitter(width = 0.1)) +
  guides(fill = FALSE)
```

<img src="03-scientific-results-polish_files/figure-html/violin-strip-1.png" width="80%" style="display: block; margin: auto;" />

We can also add larger points for the daily averages. We'll use a special layer for this: `stat_summary()`. It has a slightly different syntax, since we're not actually mapping a column from the dataset. Instead, we're feeding a column from a dataset into a function (here `"mean"`) and then plotting that result:


```r
ggplot(weather_atl,
       aes(y = windSpeed, x = Day, fill = Day)) +
  geom_violin() +
  stat_summary(geom = "point", fun = "mean", size = 5, color = "white") +
  geom_point(size = 0.5, position = position_jitter(width = 0.1)) +
  guides(fill = FALSE)
```

<img src="03-scientific-results-polish_files/figure-html/violin-strip-mean-1.png" width="80%" style="display: block; margin: auto;" />

We can also show the mean and confidence interval at the same time by changing the summary function:


```r
ggplot(weather_atl,
       aes(y = windSpeed, x = Day, fill = Day)) +
  geom_violin() +
  stat_summary(geom = "pointrange", fun.data = "mean_se", size = 1, color = "white") +
  geom_point(size = 0.5, position = position_jitter(width = 0.1)) +
  guides(fill = FALSE)
```

<img src="03-scientific-results-polish_files/figure-html/violin-strip-mean-ci-1.png" width="80%" style="display: block; margin: auto;" />

Overlaying the points directly on top of the violins shows extra information, but it's also really crowded and hard to read. If we use [the **gghalves** package](https://github.com/erocoar/gghalves), we can use special halved versions of some of these geoms like so:


```r
ggplot(weather_atl,
       aes(x = fct_rev(Day), y = temperatureHigh)) +
  geom_half_point(aes(color = Day), side = "l", size = 0.5) +
  geom_half_boxplot(aes(fill = Day), side = "r") +
  guides(color = FALSE, fill = FALSE)
```

<img src="03-scientific-results-polish_files/figure-html/gghalves-point-boxplot-1.png" width="80%" style="display: block; margin: auto;" />

Note the `side` argument for specifying which half of the column the geom goes. We can also use `geom_half_violin()`:


```r
ggplot(weather_atl,
       aes(x = fct_rev(Day), y = temperatureHigh)) +
  geom_half_point(aes(color = Day), side = "l", size = 0.5) +
  geom_half_violin(aes(fill = Day), side = "r") +
  guides(color = FALSE, fill = FALSE)
```

<img src="03-scientific-results-polish_files/figure-html/gghalves-point-violon-1.png" width="80%" style="display: block; margin: auto;" />

If we flip the plot, we can make a [rain cloud plot](https://micahallen.org/2018/03/15/introducing-raincloud-plots/):


```r
ggplot(weather_atl,
       aes(x = fct_rev(Day), y = temperatureHigh)) +
  geom_half_boxplot(aes(fill = Day), side = "l", width = 0.5, nudge = 0.1) +
  geom_half_point(aes(color = Day), side = "l", size = 0.5) +
  geom_half_violin(aes(fill = Day), side = "r") +
  guides(color = FALSE, fill = FALSE) + 
  coord_flip()
```

<img src="03-scientific-results-polish_files/figure-html/gghalves-rain-cloud-1.png" width="80%" style="display: block; margin: auto;" />

Neat!

## Building a `theme()`

Consider this example using `gapminder`:


```r
gapminder_filtered <- gapminder %>%
  filter(year > 2000)

base_plot <- ggplot(
  data = gapminder_filtered,
  mapping = aes(
    x = gdpPercap, y = lifeExp,
    color = continent, size = pop
  )
) +
  geom_point() +
  # Use dollars, and get rid of the cents part (i.e. $300 instead of $300.00)
  scale_x_log10(labels = dollar_format(accuracy = 1)) +
  # Format with commas
  scale_size_continuous(labels = comma) +
  # Use viridis
  scale_color_viridis_d(option = "plasma", end = 0.9) +
  labs(
    x = "GDP per capita", y = "Life expectancy",
    color = "Continent", size = "Population",
    title = "Here's a cool title",
    subtitle = "And here's a neat subtitle",
    caption = "Source: The Gapminder Project"
  ) +
  facet_wrap(vars(year))

base_plot
```

<img src="03-scientific-results-polish_files/figure-html/gapminder-1.png" width="80%" style="display: block; margin: auto;" />

Now we have `base_plot` to work with. Here's what it looks like with `theme_minimal()` applied to it:


```r
base_plot +
  theme_minimal()
```

<img src="03-scientific-results-polish_files/figure-html/base-minimal-1.png" width="80%" style="display: block; margin: auto;" />

That gets rid of the grey background and is a good start, but we can make lots of improvements. First let's deal with the gridlines. There are too many. We can get rid of the minor gridlines with by setting them to `element_blank()`:


```r
base_plot +
  theme_minimal() +
  theme(panel.grid.minor = element_blank())
```

<img src="03-scientific-results-polish_files/figure-html/theme1-1.png" width="80%" style="display: block; margin: auto;" />

Next let's add some typographic contrast. We'll use Roboto Condensed Regular as the base font. Before trying this, make sure you do the following:

**On macOS**:

- Run `capabilities()` in your console and verify that `TRUE` shows up under `cairo`
- If not, download and install [XQuartz](https://www.xquartz.org/)

**On Windows**:

- Run `windowsFonts()` in your console and you'll see a list of all the fonts you can use with R. It's not a very big list.

    ```text
    #> $serif
    #> [1] "TT Times New Roman"
    #>
    #> $sans
    #> [1] "TT Arial"
    #> 
    #> $mono
    #> [1] "TT Courier New"
    ```
    
    You can add Roboto Condensed to your current R session by running this in your console:

    
    ```r
    windowsFonts(`Roboto Condensed` = windowsFont("Roboto Condensed"))
    ```

    Now if you run `windowsFonts()`, you'll see it in the list:
    
    ```text
    #> $serif
    #> [1] "TT Times New Roman"
    #>
    #> $sans
    #> [1] "TT Arial"
    #> 
    #> $mono
    #> [1] "TT Courier New"
    #>
    #> $`Roboto Condensed`
    #> [1] "Roboto Condensed"
    ```

    This only takes effect for your current R session, so if you are knitting a document or if you ever plan on closing RStudio, you'll need to incorporate this font creation code into your script.

We'll use the font as the `base_family` argument. Note how I make it bold with `face` and change the size with `rel()`. Instead of manually setting some arbitrary size, I use `rel()` to resize the text in relation to the `base_size` argument. Using `rel(1.7)` means 1.7 × `base_size`, or 20.4 That will rescale according to whatever `base_size` is—if I shrink it to `base_size = 8`, the title will scale down accordingly.


```r
plot_with_good_typography <- base_plot +
  theme_minimal(base_family = "Roboto Condensed", base_size = 12) +
  theme(
    panel.grid.minor = element_blank(),
    # Bold, bigger title
    plot.title = element_text(face = "bold", size = rel(1.7)),
    # Plain, slightly bigger subtitle that is grey
    plot.subtitle = element_text(face = "plain", size = rel(1.3), color = "grey70"),
    # Italic, smaller, grey caption that is left-aligned
    plot.caption = element_text(
      face = "italic", size = rel(0.7),
      color = "grey70", hjust = 0
    ),
    # Bold legend titles
    legend.title = element_text(face = "bold"),
    # Bold, slightly larger facet titles that are left-aligned for the sake of repetition
    strip.text = element_text(face = "bold", size = rel(1.1), hjust = 0),
    # Bold axis titles
    axis.title = element_text(face = "bold"),
    # Add some space above the x-axis title and make it left-aligned
    axis.title.x = element_text(margin = margin(t = 10), hjust = 0),
    # Add some space to the right of the y-axis title and make it top-aligned
    axis.title.y = element_text(margin = margin(r = 10), hjust = 1)
  )
plot_with_good_typography
```

<img src="03-scientific-results-polish_files/figure-html/theme2-1.png" width="80%" style="display: block; margin: auto;" />

Whoa. That gets us most of the way there! We have good contrast with the typography, with the strong bold and the lighter regular font (**contrast**). Everything is aligned left (**alignment** and **repetition**). By moving the axis titles a little bit away from the labels, we've enhanced proximity, since they were too close together (**proximity**). We repeat grey in both the caption and the subtitle (**repetition**).

The only thing I don't like is that the 2002 isn't quite aligned with the title and subtitle. This is because the facet labels are in boxes along the top of each plot, and in some themes (like `theme_grey()` and `theme_bw()`) those facet labels have grey backgrounds. We can turn off the margin in those boxes, or we can add a background, which will then be perfectly aligned with the title and subtitle.


```r
plot_with_good_typography +
  # Add a light grey background to the facet titles, with no borders
  theme(
    strip.background = element_rect(fill = "grey90", color = NA),
    # Add a thin grey border around all the plots to tie in the facet titles
    panel.border = element_rect(color = "grey90", fill = NA)
  )
```

<img src="03-scientific-results-polish_files/figure-html/theme3-1.png" width="80%" style="display: block; margin: auto;" />

That looks great!

To save ourselves time in the future, we can store this whole thing as an object that we can then reuse on other plots:


```r
my_pretty_theme <- theme_minimal(base_family = "Roboto Condensed", base_size = 12) +
  theme(
    panel.grid.minor = element_blank(),
    # Bold, bigger title
    plot.title = element_text(face = "bold", size = rel(1.7)),
    # Plain, slightly bigger subtitle that is grey
    plot.subtitle = element_text(face = "plain", size = rel(1.3), color = "grey70"),
    # Italic, smaller, grey caption that is left-aligned
    plot.caption = element_text(
      face = "italic", size = rel(0.7),
      color = "grey70", hjust = 0
    ),
    # Bold legend titles
    legend.title = element_text(face = "bold"),
    # Bold, slightly larger facet titles that are left-aligned for the sake of repetition
    strip.text = element_text(face = "bold", size = rel(1.1), hjust = 0),
    # Bold axis titles
    axis.title = element_text(face = "bold"),
    # Add some space above the x-axis title and make it left-aligned
    axis.title.x = element_text(margin = margin(t = 10), hjust = 0),
    # Add some space to the right of the y-axis title and make it top-aligned
    axis.title.y = element_text(margin = margin(r = 10), hjust = 1),
    # Add a light grey background to the facet titles, with no borders
    strip.background = element_rect(fill = "grey90", color = NA),
    # Add a thin grey border around all the plots to tie in the facet titles
    panel.border = element_rect(color = "grey90", fill = NA)
  )
```

Now we can use it on any plot.


```r
mpg_example <- ggplot(
  data = mpg,
  mapping = aes(x = displ, y = hwy, color = class)
) +
  geom_point(size = 3) +
  scale_color_viridis_d() +
  facet_wrap(vars(drv)) +
  labs(
    x = "Displacement", y = "Highway MPG", color = "Car class",
    title = "Heavier cars get worse mileage",
    subtitle = "Except two-seaters?",
    caption = "Here's a caption"
  ) +
  my_pretty_theme
mpg_example
```

<img src="03-scientific-results-polish_files/figure-html/mpg-example-1.png" width="80%" style="display: block; margin: auto;" />

Super neat!

## Annotations

For this example, we're again going to use cross-national data from the [World Bank's Open Data portal](https://data.worldbank.org/). We'll download the data with the [**WDI** package](https://cran.r-project.org/web/packages/WDI/index.html).

- [`wdi_co2.csv`](https://data-mining-viz.netlify.app/data/wdi_co2.csv)

### Load data

First, we load the libraries we'll be using:


```r
library(tidyverse)  # For ggplot, dplyr, and friends
library(WDI)        # Get data from the World Bank
library(ggrepel)    # For non-overlapping labels

# You need to install ggtext from GitHub. Follow the instructions at 
# https://github.com/wilkelab/ggtext
library(ggtext)     # For fancier text handling
```


```r
indicators <- c("SP.POP.TOTL",     # Population
                "EN.ATM.CO2E.PC",  # CO2 emissions
                "NY.GDP.PCAP.KD")  # GDP per capita

wdi_co2_raw <- WDI(country = "all", indicators, extra = TRUE, 
                   start = 1995, end = 2015)
```




```r
wdi_co2_raw <- read_csv(here::here("data", "wdi_co2.csv"))
```

Then we clean the data by removing non-country countries and renaming some of the columns.


```r
wdi_clean <- wdi_co2_raw %>% 
  filter(region != "Aggregates") %>% 
  select(iso2c, iso3c, country, year, 
         population = SP.POP.TOTL,
         co2_emissions = EN.ATM.CO2E.PC, 
         gdp_per_cap = NY.GDP.PCAP.KD, 
         region, income)
```

### Clean and reshape data

Next we'll do some substantial filtering and reshaping so that we can end up with the rankings of CO~2~ emissions in 1995 and 2014. I annotate as much as possible below so you can see what's happening in each step.


```r
co2_rankings <- wdi_clean %>% 
  # Get rid of smaller countries
  filter(population > 200000) %>% 
  # Only look at two years
  filter(year %in% c(1995, 2014)) %>% 
  # Get rid of all the rows that have missing values in co2_emissions
  drop_na(co2_emissions) %>% 
  # Look at each year individually and rank countries based on their emissions that year
  group_by(year) %>% 
  mutate(ranking = rank(co2_emissions)) %>% 
  ungroup() %>% 
  # Only select a handful of columns, mostly just the newly created "ranking"
  # column and some country identifiers
  select(iso3c, country, year, region, income, ranking) %>% 
  # Right now the data is tidy and long, but we want to widen it and create
  # separate columns for emissions in 1995 and in 2014. pivot_wider() will make
  # new columns based on the existing "year" column (that's what `names_from`
  # does), and it will add "rank_" as the prefix, so that the new columns will
  # be "rank_1995" and "rank_2014". The values that go in those new columns will
  # come from the existing "ranking" column
  pivot_wider(names_from = year, names_prefix = "rank_", values_from = ranking) %>% 
  # Find the difference in ranking between 2014 and 1995
  mutate(rank_diff = rank_2014 - rank_1995) %>% 
  # Remove all rows where there's a missing value in the rank_diff column
  drop_na(rank_diff) %>% 
  # Make an indicator variable that is true of the absolute value of the
  # difference in rankings is greater than 25. 25 is arbitrary here—that just
  # felt like a big change in rankings
  mutate(big_change = ifelse(abs(rank_diff) >= 25, TRUE, FALSE)) %>% 
  # Make another indicator variable that indicates if the rank improved by a
  # lot, worsened by a lot, or didn't change much. We use the case_when()
  # function, which is like a fancy version of ifelse() that takes multiple
  # conditions. This is how it generally works:
  #
  # case_when(
  #  some_test ~ value_if_true,
  #  some_other_test ~ value_if_true,
  #  TRUE ~ value_otherwise
  #)
  mutate(better_big_change = case_when(
    rank_diff <= -25 ~ "Rank improved",
    rank_diff >= 25 ~ "Rank worsened",
    TRUE ~ "Rank changed a little"
  ))
```

Here's what that reshaped data looked like before:


```r
head(wdi_clean)
## # A tibble: 6 × 9
##   iso2c iso3c country  year population co2_emissions gdp_per_cap region   income
##   <chr> <chr> <chr>   <dbl>      <dbl>         <dbl>       <dbl> <chr>    <chr> 
## 1 AD    AND   Andorra  1995      63850          6.66      32577. Europe … High …
## 2 AD    AND   Andorra  1996      64360          7.07      33822. Europe … High …
## 3 AD    AND   Andorra  1997      64327          7.24      36907. Europe … High …
## 4 AD    AND   Andorra  1999      64370          7.98      39621. Europe … High …
## 5 AD    AND   Andorra  2000      65390          8.02      40379. Europe … High …
## 6 AD    AND   Andorra  2001      67341          7.79      42393. Europe … High …
```

And here's what it looks like now:


```r
head(co2_rankings)
## # A tibble: 6 × 9
##   iso3c country           region income rank_1995 rank_2014 rank_diff big_change
##   <chr> <chr>             <chr>  <chr>      <dbl>     <dbl>     <dbl> <lgl>     
## 1 ARE   United Arab Emir… Middl… High …       170       176         6 FALSE     
## 2 AFG   Afghanistan       South… Low i…         9        21        12 FALSE     
## 3 ALB   Albania           Europ… Upper…        54        79        25 TRUE      
## 4 ARM   Armenia           Europ… Upper…        71        77         6 FALSE     
## 5 AGO   Angola            Sub-S… Lower…        59        69        10 FALSE     
## 6 ARG   Argentina         Latin… Upper…       104       121        17 FALSE     
## # … with 1 more variable: better_big_change <chr>
```

### Plot the data and annotate

I use IBM Plex Sans in this plot. You can [download it from Google Fonts](https://fonts.google.com/specimen/IBM+Plex+Sans).


```r
# These three functions make it so all geoms that use text, label, and
# label_repel will use IBM Plex Sans as the font. Those layers are *not*
# influenced by whatever you include in the base_family argument in something
# like theme_bw(), so ordinarily you'd need to specify the font in each
# individual annotate(geom = "text") layer or geom_label() layer, and that's
# tedious! This removes that tediousness.
update_geom_defaults("text", list(family = "IBM Plex Sans"))
update_geom_defaults("label", list(family = "IBM Plex Sans"))
update_geom_defaults("label_repel", list(family = "IBM Plex Sans"))

ggplot(co2_rankings,
       aes(x = rank_1995, y = rank_2014)) +
  # Add a reference line that goes from the bottom corner to the top corner
  annotate(geom = "segment", x = 0, xend = 172, y = 0, yend = 178) +
  # Add points and color them by the type of change in rankings
  geom_point(aes(color = better_big_change)) +
  # Add repelled labels. Only use data where big_change is TRUE. Fill them by
  # the type of change (so they match the color in geom_point() above) and use
  # white text
  geom_label_repel(data = filter(co2_rankings, big_change == TRUE),
                   aes(label = country, fill = better_big_change),
                   color = "white") +
  # Add notes about what the outliers mean in the bottom left and top right
  # corners. These are italicized and light grey. The text in the bottom corner
  # is justified to the right with hjust = 1, and the text in the top corner is
  # justified to the left with hjust = 0
  annotate(geom = "text", x = 170, y = 6, label = "Outliers improving", 
           fontface = "italic", hjust = 1, color = "grey50") +
  annotate(geom = "text", x = 2, y = 170, label = "Outliers worsening", 
           fontface = "italic", hjust = 0, color = "grey50") +
  # Add mostly transparent rectangles in the bottom right and top left corners
  annotate(geom = "rect", xmin = 0, xmax = 25, ymin = 0, ymax = 25, 
           fill = "#2ECC40", alpha = 0.25) +
  annotate(geom = "rect", xmin = 150, xmax = 178, ymin = 150, ymax = 178, 
           fill = "#FF851B", alpha = 0.25) +
  # Add text to define what the rectangles abovee actually mean. The \n in
  # "highest\nemitters" will put a line break in the label
  annotate(geom = "text", x = 40, y = 6, label = "Lowest emitters", 
           hjust = 0, color = "#2ECC40") +
  annotate(geom = "text", x = 162.5, y = 135, label = "Highest\nemitters", 
           hjust = 0.5, vjust = 1, lineheight = 1, color = "#FF851B") +
  # Add arrows between the text and the rectangles. These use the segment geom,
  # and the arrows are added with the arrow() function, which lets us define the
  # angle of the arrowhead and the length of the arrowhead pieces. Here we use
  # 0.5 lines, which is a unit of measurement that ggplot uses internally (think
  # of how many lines of text fit in the plot). We could also use unit(1, "cm")
  # or unit(0.25, "in") or anything else
  annotate(geom = "segment", x = 38, xend = 20, y = 6, yend = 6, color = "#2ECC40", 
           arrow = arrow(angle = 15, length = unit(0.5, "lines"))) +
  annotate(geom = "segment", x = 162.5, xend = 162.5, y = 140, yend = 155, color = "#FF851B", 
           arrow = arrow(angle = 15, length = unit(0.5, "lines"))) +
  # Use three different colors for the points
  scale_color_manual(values = c("grey50", "#0074D9", "#FF4136")) +
  # Use two different colors for the filled labels. There are no grey labels, so
  # we don't have to specify that color
  scale_fill_manual(values = c("#0074D9", "#FF4136")) +
  # Make the x and y axes expand all the way to the edges of the plot area and
  # add breaks every 25 units from 0 to 175
  scale_x_continuous(expand = c(0, 0), breaks = seq(0, 175, 25)) +
  scale_y_continuous(expand = c(0, 0), breaks = seq(0, 175, 25)) +
  # Add labels! There are a couple fancy things here.
  # 1. In the title we wrap the 2 of CO2 in the HTML <sub></sub> tag so that the
  #    number gets subscripted. The only way this will actually get parsed as 
  #    HTML is if we tell the plot.title to use element_markdown() in the 
  #    theme() function, and element_markdown() comes from the ggtext package.
  # 2. In the subtitle we bold the two words **improved** and **worsened** using
  #    Markdown asterisks. We also wrap these words with HTML span tags with 
  #    inline CSS to specify the color of the text. Like the title, this will 
  #    only be processed and parsed as HTML and Markdown if we tell the p
  #    lot.subtitle to use element_markdown() in the theme() function.
  labs(x = "Rank in 1995", y = "Rank in 2014",
       title = "Changes in CO<sub>2</sub> emission rankings between 1995 and 2014",
       subtitle = "Countries that <span style='color: #0074D9'>**improved**</span> or <span style='color: #FF4136'>**worsened**</span> more than 25 positions in the rankings highlighted",
       caption = "Source: The World Bank.\nCountries with populations of less than 200,000 excluded.") +
  # Turn off the legends for color and fill, since the subtitle includes that
  guides(color = FALSE, fill = FALSE) +
  # Use theme_bw() with IBM Plex Sans
  theme_bw(base_family = "IBM Plex Sans") +
  # Tell the title and subtitle to be treated as Markdown/HTML, make the title
  # 1.6x the size of the base font, and make the subtitle 1.3x the size of the
  # base font. Also add a little larger margin on the right of the plot so that
  # the 175 doesn't get cut off.
  theme(plot.title = element_markdown(face = "bold", size = rel(1.6)),
        plot.subtitle = element_markdown(size = rel(1.3)),
        plot.margin = unit(c(0.5, 1, 0.5, 0.5), units = "lines"))
```

<img src="03-scientific-results-polish_files/figure-html/build-pretty-plot-1.png" width="80%" style="display: block; margin: auto;" />

## Acknowledgments {-}

* Coding examples from [Andrew Heiss](https://datavizm20.classes.andrewheiss.com/)

## Session info {-}


```r
devtools::session_info()
## ─ Session info ───────────────────────────────────────────────────────────────
##  setting  value
##  version  R version 4.1.2 (2021-11-01)
##  os       macOS Monterey 12.2.1
##  system   aarch64, darwin20
##  ui       X11
##  language (EN)
##  collate  en_US.UTF-8
##  ctype    en_US.UTF-8
##  tz       America/Chicago
##  date     2022-03-04
##  pandoc   2.17.1.1 @ /Applications/RStudio.app/Contents/MacOS/quarto/bin/ (via rmarkdown)
## 
## ─ Packages ───────────────────────────────────────────────────────────────────
##  package      * version    date (UTC) lib source
##  assertthat     0.2.1      2019-03-21 [1] CRAN (R 4.1.0)
##  backports      1.4.1      2021-12-13 [1] CRAN (R 4.1.1)
##  bit            4.0.4      2020-08-04 [1] CRAN (R 4.1.1)
##  bit64          4.0.5      2020-08-30 [1] CRAN (R 4.1.0)
##  bookdown       0.24       2021-09-02 [1] CRAN (R 4.1.1)
##  brio           1.1.3      2021-11-30 [1] CRAN (R 4.1.1)
##  broom        * 0.7.12     2022-01-28 [1] CRAN (R 4.1.1)
##  bslib          0.3.1      2021-10-06 [1] CRAN (R 4.1.1)
##  cachem         1.0.6      2021-08-19 [1] CRAN (R 4.1.1)
##  callr          3.7.0      2021-04-20 [1] CRAN (R 4.1.0)
##  cellranger     1.1.0      2016-07-27 [1] CRAN (R 4.1.0)
##  cli            3.2.0      2022-02-14 [1] CRAN (R 4.1.1)
##  codetools      0.2-18     2020-11-04 [1] CRAN (R 4.1.2)
##  colorspace   * 2.0-3      2022-02-21 [1] CRAN (R 4.1.1)
##  crayon         1.5.0      2022-02-14 [1] CRAN (R 4.1.1)
##  curl           4.3.2      2021-06-23 [1] CRAN (R 4.1.0)
##  DBI            1.1.2      2021-12-20 [1] CRAN (R 4.1.1)
##  dbplyr         2.1.1      2021-04-06 [1] CRAN (R 4.1.0)
##  desc           1.4.0      2021-09-28 [1] CRAN (R 4.1.1)
##  devtools     * 2.4.3      2021-11-30 [1] CRAN (R 4.1.1)
##  dichromat    * 2.0-0      2013-01-24 [1] CRAN (R 4.1.0)
##  digest         0.6.29     2021-12-01 [1] CRAN (R 4.1.1)
##  dplyr        * 1.0.8      2022-02-08 [1] CRAN (R 4.1.1)
##  ellipsis       0.3.2      2021-04-29 [1] CRAN (R 4.1.0)
##  emo            0.0.0.9000 2022-01-06 [1] Github (hadley/emo@3f03b11)
##  evaluate       0.15       2022-02-18 [1] CRAN (R 4.1.1)
##  fansi          1.0.2      2022-01-14 [1] CRAN (R 4.1.1)
##  farver         2.1.0      2021-02-28 [1] CRAN (R 4.1.0)
##  fastmap        1.1.0      2021-01-25 [1] CRAN (R 4.1.0)
##  forcats      * 0.5.1      2021-01-27 [1] CRAN (R 4.1.1)
##  fs             1.5.2      2021-12-08 [1] CRAN (R 4.1.1)
##  gapminder    * 0.3.0      2017-10-31 [1] CRAN (R 4.1.0)
##  generics       0.1.2      2022-01-31 [1] CRAN (R 4.1.1)
##  gghalves     * 0.1.1      2020-11-08 [1] CRAN (R 4.1.1)
##  ggplot2      * 3.3.5      2021-06-25 [1] CRAN (R 4.1.1)
##  ggrepel      * 0.9.1      2021-01-15 [1] CRAN (R 4.1.1)
##  ggridges     * 0.5.3      2021-01-08 [1] CRAN (R 4.1.1)
##  ggtext       * 0.1.1      2020-12-17 [1] CRAN (R 4.1.1)
##  ggthemes     * 4.2.4      2021-01-20 [1] CRAN (R 4.1.0)
##  glue           1.6.1      2022-01-22 [1] CRAN (R 4.1.1)
##  gridtext       0.1.4      2020-12-10 [1] CRAN (R 4.1.0)
##  gtable         0.3.0      2019-03-25 [1] CRAN (R 4.1.1)
##  haven          2.4.3      2021-08-04 [1] CRAN (R 4.1.1)
##  here         * 1.0.1      2020-12-13 [1] CRAN (R 4.1.0)
##  highr          0.9        2021-04-16 [1] CRAN (R 4.1.0)
##  hms            1.1.1      2021-09-26 [1] CRAN (R 4.1.1)
##  htmltools      0.5.2      2021-08-25 [1] CRAN (R 4.1.1)
##  httr           1.4.2      2020-07-20 [1] CRAN (R 4.1.0)
##  jquerylib      0.1.4      2021-04-26 [1] CRAN (R 4.1.0)
##  jsonlite       1.8.0      2022-02-22 [1] CRAN (R 4.1.1)
##  knitr        * 1.37       2021-12-16 [1] CRAN (R 4.1.1)
##  labeling       0.4.2      2020-10-20 [1] CRAN (R 4.1.0)
##  lifecycle      1.0.1      2021-09-24 [1] CRAN (R 4.1.1)
##  lubridate    * 1.8.0      2021-10-07 [1] CRAN (R 4.1.1)
##  magrittr       2.0.2      2022-01-26 [1] CRAN (R 4.1.1)
##  markdown       1.1        2019-08-07 [1] CRAN (R 4.1.0)
##  memoise        2.0.1      2021-11-26 [1] CRAN (R 4.1.1)
##  modelr         0.1.8      2020-05-19 [1] CRAN (R 4.1.0)
##  munsell        0.5.0      2018-06-12 [1] CRAN (R 4.1.0)
##  patchwork    * 1.1.1      2020-12-17 [1] CRAN (R 4.1.1)
##  pillar         1.7.0      2022-02-01 [1] CRAN (R 4.1.1)
##  pkgbuild       1.3.1      2021-12-20 [1] CRAN (R 4.1.1)
##  pkgconfig      2.0.3      2019-09-22 [1] CRAN (R 4.1.0)
##  pkgload        1.2.4      2021-11-30 [1] CRAN (R 4.1.1)
##  plyr           1.8.6      2020-03-03 [1] CRAN (R 4.1.0)
##  prettyunits    1.1.1      2020-01-24 [1] CRAN (R 4.1.0)
##  processx       3.5.2      2021-04-30 [1] CRAN (R 4.1.0)
##  ps             1.6.0      2021-02-28 [1] CRAN (R 4.1.0)
##  purrr        * 0.3.4      2020-04-17 [1] CRAN (R 4.1.0)
##  R6             2.5.1      2021-08-19 [1] CRAN (R 4.1.1)
##  RColorBrewer * 1.1-2      2014-12-07 [1] CRAN (R 4.1.0)
##  Rcpp           1.0.8      2022-01-13 [1] CRAN (R 4.1.1)
##  readr        * 2.1.2      2022-01-30 [1] CRAN (R 4.1.1)
##  readxl         1.3.1      2019-03-13 [1] CRAN (R 4.1.0)
##  remotes        2.4.2      2021-11-30 [1] CRAN (R 4.1.1)
##  reprex         2.0.1      2021-08-05 [1] CRAN (R 4.1.1)
##  RJSONIO        1.3-1.6    2021-09-16 [1] CRAN (R 4.1.1)
##  rlang          1.0.1      2022-02-03 [1] CRAN (R 4.1.1)
##  rmarkdown      2.11       2021-09-14 [1] CRAN (R 4.1.1)
##  rprojroot      2.0.2      2020-11-15 [1] CRAN (R 4.1.0)
##  rstudioapi     0.13       2020-11-12 [1] CRAN (R 4.1.0)
##  rvest          1.0.2      2021-10-16 [1] CRAN (R 4.1.1)
##  sass           0.4.0      2021-05-12 [1] CRAN (R 4.1.0)
##  scales       * 1.1.1      2020-05-11 [1] CRAN (R 4.1.0)
##  sessioninfo    1.2.2      2021-12-06 [1] CRAN (R 4.1.1)
##  socviz       * 1.2        2020-06-10 [1] CRAN (R 4.1.0)
##  stringi        1.7.6      2021-11-29 [1] CRAN (R 4.1.1)
##  stringr      * 1.4.0      2019-02-10 [1] CRAN (R 4.1.1)
##  testthat       3.1.2      2022-01-20 [1] CRAN (R 4.1.1)
##  tibble       * 3.1.6      2021-11-07 [1] CRAN (R 4.1.1)
##  tidyr        * 1.2.0      2022-02-01 [1] CRAN (R 4.1.1)
##  tidyselect     1.1.2      2022-02-21 [1] CRAN (R 4.1.1)
##  tidyverse    * 1.3.1      2021-04-15 [1] CRAN (R 4.1.0)
##  tzdb           0.2.0      2021-10-27 [1] CRAN (R 4.1.1)
##  usethis      * 2.1.5      2021-12-09 [1] CRAN (R 4.1.1)
##  utf8           1.2.2      2021-07-24 [1] CRAN (R 4.1.0)
##  vctrs          0.3.8      2021-04-29 [1] CRAN (R 4.1.0)
##  viridisLite    0.4.0      2021-04-13 [1] CRAN (R 4.1.0)
##  vroom          1.5.7      2021-11-30 [1] CRAN (R 4.1.1)
##  WDI          * 2.7.6      2022-02-25 [1] CRAN (R 4.1.1)
##  withr          2.4.3      2021-11-30 [1] CRAN (R 4.1.1)
##  xfun           0.29       2021-12-14 [1] CRAN (R 4.1.1)
##  xml2           1.3.3      2021-11-30 [1] CRAN (R 4.1.1)
##  yaml           2.3.5      2022-02-21 [1] CRAN (R 4.1.1)
## 
##  [1] /Library/Frameworks/R.framework/Versions/4.1-arm64/Resources/library
## 
## ──────────────────────────────────────────────────────────────────────────────
```
