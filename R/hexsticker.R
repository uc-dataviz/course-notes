library(tidyverse)
library(rcfss)
library(hexSticker)
library(here)

library(showtext)
font_add_google("Roboto Condensed", "roboto")
showtext_auto()

p <- scorecard %>%
  mutate(type = fct_infreq(f = type)) %>%
  ggplot(mapping = aes(x = type, fill = type)) +
  geom_bar(color = NA) +
  scale_fill_manual(values = c("#EAAA00", "#F3D03E", "#CC8A00"), guide = "none") +
  annotate(geom = "text", label = "MACS 40700", x = 2, y = 1600, size = 4,
           family = "roboto", fontface = "bold", color = "#FFFFFF") +
  annotate(geom = "text", label = "Data Visualization", x = 2, y = 1375, size = 3.5, color = "#FFFFFF",
           family = "roboto") +
  theme_void() +
  theme_transparent()
p

sticker(subplot = p, package = " ",
        h_color = "#D9D9D9", h_fill = "#800000", p_color = "#800000",
        s_x = 1, s_y = 0.95,
        s_width = 1, s_height = 1.3,
        filename = here("images", "hexsticker.svg"))
