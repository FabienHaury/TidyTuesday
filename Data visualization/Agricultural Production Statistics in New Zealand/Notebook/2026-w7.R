# creer_dossiers_date_et_graphique("2026-02-17")
# Import & co ----

## Load global settings ----
source("~/R things/Tidytuesday/global_settings.R")

## Load additional required libraries ----
library(dplyr)
library(tidyverse)
library(tidytuesdayR)
library(ggtext)
library(gt)
library(patchwork)

extrafont::loadfonts(device = c("all"), quiet = TRUE)

## Load data ----
tuesdata <- tidytuesdayR::tt_load(2026, week = 7)
df <- tuesdata$dataset
rm(tuesdata)

## THEME SYSTEM ----
# Thème global de base, utilisé partout
theme_global <- function() {
  theme_minimal(base_family = "Verdana") +
    theme(
      panel.grid.major.x = element_blank(),
      panel.grid.major.y = element_line(
        linetype = "dotted",
        linewidth = 0.5,
        color = "grey70"
      ),
      panel.grid.minor = element_blank(),
      axis.line.x.bottom = element_line(color = "black", linewidth = 0.25),
      axis.line.y = element_line(color = "black", linewidth = 0.25),
      axis.text = element_text(
        colour = "grey20",
        face = "bold",
        size = 10
      ),
      axis.title = element_text(
        colour = "grey10",
        face = "bold",
        size = 14
      ),
      axis.ticks.x.bottom = element_line(color = "black"),
      axis.ticks.y = element_blank(),
      axis.title.x = element_text(margin = margin(t = 10)),
      axis.title.y = element_text(margin = margin(r = 10)),
      plot.margin = margin(0.015, 0.015, 0.015, 0.015, "npc"),
      plot.title = element_markdown(
        colour = "grey20",
        face = "bold",
        size = 18
      ),
      plot.subtitle = element_markdown(
        colour = "grey10",
        face = "italic",
        size = 14
      ),
      plot.caption = element_markdown(
        colour = "grey10",
        face = "italic",
        hjust = 0,
        size = 10
      )
    )
}

# Variante avec fond crème
theme_creme <- function() {
  theme_global() +
    theme(
      plot.background = element_rect(fill = "#F1E9D2", color = "#F1E9D2")
    )
}

# Variante simple pour certains graphiques (si besoin)
theme_simple <- function() {
  theme_minimal(base_family = "Verdana") +
    theme(
      panel.grid.major.x = element_blank(),
      panel.grid.minor = element_blank(),
      axis.line = element_line(color = "black", linewidth = 0.25),
      axis.text = element_text(
        colour = "grey20",
        face = "bold",
        size = 10
      ),
      axis.title = element_text(
        colour = "grey10",
        face = "bold",
        size = 14
      )
    )
}

# Data wrangling ----
df <- df |> select(-c("value_unit"))

df <- df |>
  mutate(
    decade = case_when(
      between(year_ended_june, 2020, 2029) ~ "2020s",
      between(year_ended_june, 2010, 2019) ~ "2010s",
      between(year_ended_june, 2000, 2009) ~ "2000s",
      between(year_ended_june, 1990, 1999) ~ "1990s",
      between(year_ended_june, 1980, 1989) ~ "1980s",
      between(year_ended_june, 1970, 1979) ~ "1970s",
      between(year_ended_june, 1960, 1969) ~ "1960s",
      between(year_ended_june, 1950, 1959) ~ "1950s",
      between(year_ended_june, 1940, 1949) ~ "1940s",
      between(year_ended_june, 1935, 1939) ~ "1930s",
      TRUE ~ NA_character_
    )
  )

# EDA ----
## Total Sheep ----
df_tot_sheep <- df %>%
  filter(measure == "Total Sheep") %>%
  complete(
    year_ended_june = full_seq(year_ended_june, period = 1),
    fill = list(value = NA)
  ) %>%
  mutate(decade = paste0(floor(year_ended_june / 10) * 10, "s")) %>%
  group_by(decade) %>%
  mutate(avg = mean(value, na.rm = TRUE)) %>%
  ungroup() %>%
  select(-c(measure, value_label))

df_tot_sheep_label <- df_tot_sheep |>
  mutate(max_val = ceiling(max(value, na.rm = TRUE) / 5e6) * 5e6) |>
  group_by(decade) |>
  slice_min(
    abs(year_ended_june - (as.numeric(substr(decade, 1, 4)) + 5)),
    with_ties = FALSE
  ) |>
  ungroup()

min_val_y <- floor(min(df_tot_sheep$value, na.rm = TRUE) / 5e6) * 5e6
max_val_y <- ceiling(max(df_tot_sheep$value, na.rm = TRUE) / 5e6) * 5e6
breaks_y <- seq(min_val_y, max_val_y, by = 5e6)
min_lim_y <- min(breaks_y)
max_lim_y <- max(breaks_y)
year_missing <- "Data missing for: 1997, 1998, 2000, 2001"

ggplot(df_tot_sheep, aes(year_ended_june, value, color = decade)) +
  geom_segment(
    aes(
      x = year_ended_june,
      xend = lead(year_ended_june),
      y = avg,
      yend = avg
    ),
    linewidth = 2,
    na.rm = TRUE
  ) +
  geom_segment(
    aes(x = year_ended_june, xend = year_ended_june, y = avg, yend = value),
    linetype = "dashed",
    linewidth = 0.5
  ) +
  geom_point(size = 2.5) +
  geom_label(
    data = df_tot_sheep_label,
    aes(x = year_ended_june, y = max_val, label = decade),
    fill = "#F1E9D2",
    vjust = -0.2,
    family = "Verdana",
    fontface = "bold",
    size = 6
  ) +
  annotate(
    geom = "curve",
    x = 1995,
    xend = 1997.5,
    y = 42000000,
    yend = 46000000,
    curvature = .35,
    angle = 60,
    color = "grey10",
    linewidth = .4,
    arrow = arrow(type = "closed", length = unit(.08, "inches"))
  ) +
  annotate(
    geom = "curve",
    x = 1995,
    xend = 2000.5,
    y = 42000000,
    yend = 39000000,
    curvature = -.35,
    angle = 60,
    color = "grey10",
    linewidth = .4,
    arrow = arrow(type = "closed", length = unit(.08, "inches"))
  ) +
  annotate(
    geom = "richtext",
    x = 1980,
    y = 42000000,
    label = year_missing,
    family = "Verdana",
    fontface = "bold",
    size = 5,
    color = "grey10",
    hjust = 0,
    vjust = 1,
    fill = "#F1E9D2",
    label.color = NA
  ) +
  scale_x_continuous(
    limits = c(1930, 2030),
    breaks = seq(1930, 2030, 10),
    expand = c(0.01, 0.01)
  ) +
  scale_y_continuous(
    limits = c(min_lim_y, max_lim_y),
    breaks = breaks_y,
    labels = scales::label_number(suffix = " M", scale = 1e-6),
    sec.axis = dup_axis(name = NULL),
    expand = c(0, 0, 0.05, 0)
  ) +
  paletteer::scale_colour_paletteer_d("ggsci::default_aaas") +
  lemon::coord_capped_cart(
    bottom = 'none',
    left = "none",
    right = "none"
  ) +
  labs(
    title = "New Zealand’s sheep population: A century of change, decade by decade",
    subtitle = "Yearly sheep counts (dots) compared to decade averages (horizontal lines).",
    caption = "Author: Fabien Haury | Source: #Tidytuesday 2026-02-17",
    x = "Year",
    y = "Number of sheep"
  ) +
  theme_creme() +
  guides(color = "none")

# sauvegarder_graphique_ggplot(
#   plt,
#   "2026-02-17",
#   "graph_total_sheep.png",
#   25,
#   20,
#   300,
#   forcer = TRUE
# )
