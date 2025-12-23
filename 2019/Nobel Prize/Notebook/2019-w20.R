# Import & co ---------------------------------------------

## Load global settings ----
source("~/R things/Tidytuesday/global_settings.R")

## Load additional required libraries ----
library(dplyr)
library(tidyverse)
library(tidytuesdayR)
library(ggtext)
library(patchwork)
library(shadowtext)
library(grid)

extrafont::loadfonts(device = c("all"), quiet = TRUE)


## Load data ----
nobel_winners <- readr::read_csv(
  "https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2019/2019-05-14/nobel_winners.csv"
)
nobel_winner_all_pubs <- readr::read_csv(
  "https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2019/2019-05-14/nobel_winner_all_pubs.csv"
)

# EDA -----
## nobel prize timeline ----
nw_gender <- nobel_winners %>%
  #filter(prize_year >= 1900 & prize_year <= 1950) |>
  select(prize_year, gender) %>%
  drop_na() %>%
  mutate(prize_year = as.integer(prize_year)) %>%
  count(prize_year, gender, name = "n") %>%
  pivot_wider(
    names_from = gender,
    values_from = n,
    values_fill = 0,
    names_prefix = "n_"
  ) %>%
  rename(
    n_male = n_Male,
    n_female = n_Female
  ) |>
  arrange(desc(prize_year))

n_min <- min(nw_gender$n_female, na.rm = TRUE)
n_max <- max(nw_gender$n_male + 1, na.rm = TRUE)
year_min <- min(nw_gender$prize_year - 1, na.rm = TRUE)
year_max <- max(nw_gender$prize_year + 1, na.rm = TRUE)

plt <- ggplot(nw_gender) +
  geom_rect(
    data = data.frame(
      xmin = n_min,
      xmax = n_max - 1,
      ymin = 1914,
      ymax = 1918
    ),
    aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax),
    fill = "purple",
    alpha = 0.15
  ) +
  annotate(
    "text",
    x = 13,
    y = 1916,
    label = c("World War 1"),
    color = "black",
    size = 8,
    family = "Roboto Mono",
    fontface = "bold.italic"
  ) +
  geom_rect(
    data = data.frame(
      xmin = n_min,
      xmax = n_max - 1,
      ymin = 1939,
      ymax = 1945
    ),
    aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax),
    fill = "purple",
    alpha = 0.15
  ) +
  annotate(
    "text",
    x = 13,
    y = 1942,
    label = c("World War 2"),
    color = "black",
    size = 8,
    family = "Roboto Mono",
    fontface = "bold.italic"
  ) +
  geom_segment(
    data = data.frame(x_ = 11, y_ = 1968, x_end = 7.2, y_end = 1968),
    aes(x = x_, y = y_, xend = x_end, yend = y_end),
    arrow = arrow(
      angle = 25,
      length = unit(0.08, "inches"),
      ends = "last",
      type = "closed"
    )
  ) +
  geom_richtext(
    data = data.frame(x_ = 11.1, y_ = 1968),
    aes(
      x = x_,
      y = y_,
      label = "1968: introduction of the prize <br> in economic sciences."
    ),
    hjust = 0,
    vjust = 0.5,
    fill = NA,
    label.color = NA,
    family = "Roboto Mono",
    fontface = "bold.italic",
    size = 5
  ) +
  geom_segment(
    data = nw_gender,
    aes(
      x = n_female,
      xend = n_male,
      y = prize_year,
      yend = prize_year
    ),
    color = "#a0a0a0",
    linewidth = 1,
    alpha = 0.4
  ) +
  geom_point(
    aes(x = n_male, y = prize_year),
    colour = "#1b9e77",
    size = 3
  ) +
  geom_point(
    data = nw_gender,
    aes(x = n_female, y = prize_year),
    colour = "#d95f02",
    size = 3
  ) +
  scale_x_continuous(
    limits = c(n_min, n_max),
    breaks = seq(n_min, n_max, by = 2),
    expand = expansion(add = c(0.15, 0.15)),
    position = "top"
  ) +
  scale_y_reverse(
    limits = c(year_min, year_max + 3),
    breaks = seq(year_min, year_max + 3, by = 10),
    expand = expansion(mult = c(0.01, 0.01))
  ) +
  lemon::coord_capped_cart(top = "both", left = "both") +
  labs(
    title = "A century-long dive into the history of the Nobel Prizes",
    subtitle = "Number of <span style='color:#1b9e77;'>Men</span> and <span style='color:#d95f02;'>Women</span> winners through time",
    caption = "**Created by**: Fabien Haury | **Source**: #Tidytuesday 2019-05-14"
  ) +
  theme(
    axis.title.x = element_blank(),
    axis.line = element_line(),
    axis.line.x.top = element_line(
      linewidth = 0.35,
      arrow = arrow(
        angle = 30,
        length = unit(0.15, "inches"),
        ends = "last",
        type = "closed"
      )
    ),
    axis.ticks.x = element_blank(),
    axis.text.x.top = element_text(vjust = 1, margin = margin(t = 5, b = 5)),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.title.y = element_blank(),
    axis.ticks.y = element_blank(),
    axis.text.y.left = element_text(hjust = 0, margin = margin(r = 5)),
    axis.line.y.left = element_line(
      linewidth = 0.35,
      arrow = arrow(
        angle = 30,
        length = unit(0.15, "inches"),
        ends = "first",
        type = "closed"
      )
    ),
    panel.background = element_rect(fill = "white", color = NA),
    panel.border = element_blank(),
    plot.background = element_rect(fill = "white", color = NA),
    plot.margin = margin(0.01, 0.01, 0.01, 0.01, "npc"),
    plot.title = element_markdown(
      family = "Roboto",
      face = "bold",
      size = 22,
      hjust = 0,
      vjust = 5
    ),
    plot.subtitle = element_markdown(
      family = "Roboto",
      face = "italic",
      size = 18,
      hjust = 0
    ),
    plot.caption = element_markdown(
      family = "Roboto",
      face = "plain",
      size = 10,
      hjust = 0
    )
    #panel.border = element_rect(colour = "red") # dont forget to remove !
  )

# sauvegarder_graphique_ggplot(
#   plt,
#   "2019-05-14",
#   "graph_nobel_prize_timeline.png",
#   20,
#   25,
#   dpi = 600,
#   forcer = TRUE
# )

## Birth country ----
nw_country <- nobel_winners |>
  group_by(birth_country) |>
  drop_na() |>
  summarise(n = n()) |>
  slice_max(n, n = 10, with_ties = FALSE) |>
  arrange(desc(n))

plt <- ggplot(nw_country) +
  geom_col(
    aes(n, reorder(birth_country, n)),
    fill = "#076fa2",
    colour = "black",
    linewidth = 0.2,
    width = 0.6
  ) +
  geom_shadowtext(
    aes(0, reorder(birth_country, n), label = birth_country),
    hjust = 0,
    vjust = 0.5,
    nudge_x = 0.5,
    nudge_y = 0.15,
    colour = "#FFFFFF",
    bg.colour = "#076fa2",
    bg.r = 0.1,
    family = "Noto Sans Condensed",
    fontface = "bold",
    size = 6
  ) +
  geom_shadowtext(
    aes(0, reorder(birth_country, n), label = n),
    hjust = 0,
    vjust = 0.5,
    nudge_x = 0.5,
    nudge_y = -0.15,
    colour = "#FFFFFF",
    bg.colour = "#076fa2",
    bg.r = 0.1,
    family = "Noto Sans Condensed",
    fontface = "bold",
    size = 6
  ) +
  scale_x_continuous(
    limits = c(0, 126),
    breaks = seq(0, 125, 25),
    expand = c(0, 0),
    position = "top"
  ) +
  scale_y_discrete(expand = expansion(add = c(0, 0.5))) +
  theme(
    panel.background = element_rect(fill = "white"),
    panel.grid.major.x = element_line(color = "#A8BAC4", linewidth = 0.3),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.y = element_blank(),
    axis.ticks.length = unit(0, "mm"),
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    axis.line.y.left = element_line(color = "black"),
    axis.text.y = element_blank(),
    axis.text.x = element_text(family = "Noto Sans", size = 16),
    plot.margin = margin(0.15, 0.01, 0.1, 0.01, "npc")
  )


ragg::agg_png(
  "C:/Users/fabie/Documents/R things/Tidytuesday/Date/2019-05-14/Graphique_tableau/graph_nw_country.png",
  width = 16,
  height = 12,
  units = "in",
  res = 400
)

print(plt)

grid.text(
  "Top 10 most decorated countries in Nobel Prizes.",
  x = 0.01,
  y = 0.925,
  just = c("left", "bottom"),
  gp = gpar(
    fontfamily = "Noto Sans",
    fontface = "bold",
    fontsize = 24
  )
)

grid.text(
  "From 1901 to 2016.",
  x = 0.01,
  y = 0.875,
  just = c("left", "bottom"),
  gp = gpar(
    fontfamily = "Noto Sans",
    fontface = "bold.italic",
    fontsize = 20
  )
)

grid.text(
  "Created by: Fabien Haury | Source: Nobel Prizes winner through #Tidytuesday 2019-05-14",
  x = 0.01,
  y = 0.06,
  just = c("left", "bottom"),
  gp = gpar(
    fontfamily = "Noto Sans",
    fontsize = 16
  )
)

grid.text(
  "Visualisation inspiration from The Economist",
  x = 0.01,
  y = 0.01,
  just = c("left", "bottom"),
  gp = gpar(
    fontfamily = "Noto Sans",
    fontsize = 16
  )
)

grid.lines(
  x = c(0, 1),
  y = 1,
  gp = gpar(col = "red", lwd = 4)
)

grid.rect(
  x = 0,
  y = 1,
  width = 0.05,
  height = 0.025,
  gp = gpar(fill = "red", lwd = 0)
)

dev.off()

## Most decorated country by category ----
counts_by_country_cat <- nobel_winners |>
  drop_na(birth_country, category) |>
  group_by(category, birth_country) |>
  summarise(n = n(), .groups = "drop")

top5_by_category <- counts_by_country_cat |>
  group_by(category) |>
  slice_max(order_by = n, n = 5, with_ties = FALSE) |>
  ungroup()

country_colors <- c(
  "United States of America" = "#1f77b4",
  "Germany" = "#ff7f0e",
  "United Kingdom" = "#2ca02c",
  "France" = "#d62728",
  "Japan" = "#9467bd",
  "Norway" = "#8c564b",
  "Canada" = "#e377c2",
  "Sweden" = "#7f7f7f",
  "Italy" = "#bcbd22",
  "Australia" = "#17becf",
  "Netherlands" = "#aec7e8"
)

plt <- top5_by_category |>
  ggplot(aes(values = n, fill = birth_country)) +
  waffle::geom_waffle(
    n_rows = 5,
    color = "white",
    size = 1.125,
    flip = TRUE
  ) +
  facet_wrap(vars(category), space = "free_x") +
  scale_y_continuous(
    expand = expansion(add = c(0, 1))
  ) +
  scale_fill_manual(values = country_colors) +
  labs(
    title = "The Geography of Excellence: Top Countries in Each Nobel Prize Category",
    subtitle = "An overview of the five most awarded countries in each Nobel Prize category since 1901.",
    caption = "Based on Nobel Prize winners data (1901–2016) <br> Source: #TidyTuesday 2019-05-14, visualized by Fabien Haury"
  ) +
  theme(
    plot.title = element_markdown(
      family = "Noto Sans",
      face = "bold",
      size = 24,
      hjust = 0,
      margin = margin(0.01, 0.01, 0.01, 0.01, "npc")
    ),
    plot.subtitle = element_markdown(
      family = "Noto Sans",
      face = "plain",
      size = 18,
      hjust = 0,
      margin = margin(0.01, 0.01, 0.02, 0.01, "npc")
    ),
    plot.caption = element_markdown(
      family = "Noto Sans",
      face = "plain",
      size = 10,
      hjust = 0,
      margin = margin(0.02, 0.01, 0.01, 0.01, "npc")
    ),
    plot.margin = margin(0.01, 0.01, 0.01, 0.01, "npc"),
    panel.background = element_rect(fill = "white"),
    panel.grid = element_blank(),
    axis.title = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    strip.background.x = element_rect(fill = "dimgrey"),
    strip.text.x = element_text(
      family = "Noto Sans",
      face = "bold",
      size = 15,
      colour = "white"
    ),
    strip.text.y = element_text(color = "white"),
    legend.position = "bottom",
    legend.margin = margin(0.01, 0.01, 0.02, 0.01, "npc"),
    legend.title = element_blank(),
    legend.text = element_text(
      family = "Noto Sans",
      face = "bold",
      size = 10
    )
  ) +
  guides(fill = guide_legend(nrow = 1))


sauvegarder_graphique_ggplot(
  plt,
  "2019-05-14",
  "graph_waffle_top5_category.png",
  15,
  10
)
