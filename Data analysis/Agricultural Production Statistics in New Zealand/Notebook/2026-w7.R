# creer_dossiers_date_et_graphique("2026-02-17")
# Import & co ----

## Load global settings ----
source("~/R things/Tidytuesday/global_settings.R")
source("~/R things/Tidytuesday/Date/2026-02-17/function.R")

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
## Data viz ----
### Sheep data ----
# df_tot_sheep <- df %>%
#   filter(measure == "Total Sheep") %>%
#   complete(
#     year_ended_june = full_seq(year_ended_june, period = 1),
#     fill = list(value = NA)
#   ) %>%
#   mutate(decade = paste0(floor(year_ended_june / 10) * 10, "s")) %>%
#   group_by(decade) %>%
#   mutate(avg = mean(value, na.rm = TRUE)) %>%
#   ungroup() %>%
#   select(-c(measure, value_label))

# df_tot_sheep_label <- df_tot_sheep |>
#   mutate(max_val = ceiling(max(value, na.rm = TRUE) / 5e6) * 5e6) |>
#   group_by(decade) |>
#   slice_min(
#     abs(year_ended_june - (as.numeric(substr(decade, 1, 4)) + 5)),
#     with_ties = FALSE
#   ) |>
#   ungroup()

# min_val_y <- floor(min(df_tot_sheep$value, na.rm = TRUE) / 5e6) * 5e6
# max_val_y <- ceiling(max(df_tot_sheep$value, na.rm = TRUE) / 5e6) * 5e6
# breaks_y <- seq(min_val_y, max_val_y, by = 5e6)
# min_lim_y <- min(breaks_y)
# max_lim_y <- max(breaks_y)
# year_missing <- "Data missing for: 1997, 1998, 2000, 2001"

# ggplot(df_tot_sheep, aes(year_ended_june, value, color = decade)) +
#   geom_segment(
#     aes(
#       x = year_ended_june,
#       xend = lead(year_ended_june),
#       y = avg,
#       yend = avg
#     ),
#     linewidth = 2,
#     na.rm = TRUE
#   ) +
#   geom_segment(
#     aes(x = year_ended_june, xend = year_ended_june, y = avg, yend = value),
#     linetype = "dashed",
#     linewidth = 0.5
#   ) +
#   geom_point(size = 2.5) +
#   geom_label(
#     data = df_tot_sheep_label,
#     aes(x = year_ended_june, y = max_val, label = decade),
#     fill = "#F1E9D2",
#     vjust = -0.2,
#     family = "Verdana",
#     fontface = "bold",
#     size = 6
#   ) +
#   annotate(
#     geom = "curve",
#     x = 1995,
#     xend = 1997.5,
#     y = 42000000,
#     yend = 46000000,
#     curvature = .35,
#     angle = 60,
#     color = "grey10",
#     linewidth = .4,
#     arrow = arrow(type = "closed", length = unit(.08, "inches"))
#   ) +
#   annotate(
#     geom = "curve",
#     x = 1995,
#     xend = 2000.5,
#     y = 42000000,
#     yend = 39000000,
#     curvature = -.35,
#     angle = 60,
#     color = "grey10",
#     linewidth = .4,
#     arrow = arrow(type = "closed", length = unit(.08, "inches"))
#   ) +
#   annotate(
#     geom = "richtext",
#     x = 1980,
#     y = 42000000,
#     label = year_missing,
#     family = "Verdana",
#     fontface = "bold",
#     size = 5,
#     color = "grey10",
#     hjust = 0,
#     vjust = 1,
#     fill = "#F1E9D2",
#     label.color = NA
#   ) +
#   scale_x_continuous(
#     limits = c(1930, 2030),
#     breaks = seq(1930, 2030, 10),
#     expand = c(0.01, 0.01)
#   ) +
#   scale_y_continuous(
#     limits = c(min_lim_y, max_lim_y),
#     breaks = breaks_y,
#     labels = scales::label_number(suffix = " M", scale = 1e-6),
#     sec.axis = dup_axis(name = NULL),
#     expand = c(0, 0, 0.05, 0)
#   ) +
#   paletteer::scale_colour_paletteer_d("ggsci::default_aaas") +
#   lemon::coord_capped_cart(
#     bottom = 'none',
#     left = "none",
#     right = "none"
#   ) +
#   labs(
#     title = "New Zealand’s sheep population: A century of change, decade by decade",
#     subtitle = "Yearly sheep counts (dots) compared to decade averages (horizontal lines).",
#     caption = "Author: Fabien Haury | Source: #Tidytuesday 2026-02-17",
#     x = "Year",
#     y = "Number of sheep"
#   ) +
#   theme_creme() +
#   guides(color = "none")

# sauvegarder_graphique_ggplot(
#   plt,
#   "2026-02-17",
#   "graph_total_sheep.png",
#   25,
#   20,
#   300,
#   forcer = TRUE
# )

### All crops data ----
wheat_yield <- df |>
  filter(measure == "Wheat (yield)", ignore.case = TRUE) |>
  mutate(measure = "Wheat") |>
  complete(
    year_ended_june = full_seq(year_ended_june, period = 1),
    fill = list(measure = "Wheat")
  ) |>
  select(-c(value_label, decade))

barley_yield <- df |>
  filter(measure == "Barley (yield)", ignore.case = TRUE) |>
  mutate(measure = "Barley") |>
  complete(
    year_ended_june = full_seq(year_ended_june, period = 1),
    fill = list(measure = "Barley")
  ) |>
  select(-c(value_label, decade))

maize_yield <- df |>
  filter(measure == "Maize (yield)", ignore.case = TRUE) |>
  mutate(measure = "Maize") |>
  complete(
    year_ended_june = full_seq(year_ended_june, period = 1),
    fill = list(measure = "Maize")
  ) |>
  select(-c(value_label, decade))


oats_yield <- df |>
  filter(measure == "Oats (yield)", ignore.case = TRUE) |>
  mutate(measure = "Oats") |>
  complete(
    year_ended_june = full_seq(year_ended_june, period = 1),
    fill = list(measure = "Oats")
  ) |>
  select(-c(value_label, decade))


df_all_crops <- rbind(wheat_yield, barley_yield, maize_yield, oats_yield)


df_all_crops_repel <- df_all_crops |>
  group_by(measure) |>
  slice_tail(n = 1) |>
  ungroup()


plt <- df_all_crops |>
  ggplot(aes(year_ended_june, value, group = measure, color = measure)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 1, alpha = 0.5) +
  ggrepel::geom_text_repel(
    data = df_all_crops_repel,
    aes(label = measure, x = 2024, y = value),
    hjust = 0,
    nudge_x = 1,
    family = "Verdana",
    fontface = "bold",
    size = 5,
    direction = "y",
    segment.size = .7,
    segment.alpha = .5,
    segment.linetype = "dotted",
    box.padding = .4,
    segment.curvature = -0.1,
    segment.ncp = 3,
    segment.angle = 20
  ) +
  coord_cartesian(clip = "off") +
  scale_x_continuous(
    limits = c(1935, 2025),
    breaks = seq(1935, 2025, 5),
    expand = expansion(
      mult = c(0.01, 0.05),
      add = c(0, 0)
    )
  ) +
  scale_y_continuous(
    limits = c(
      0,
      ceiling(max(df_all_crops$value, na.rm = TRUE) / 1e5 * 2) / 2 * 1e5
    ),
    breaks = seq(
      0,
      ceiling(max(df_all_crops$value, na.rm = TRUE) / 1e5 * 2) / 2,
      by = 0.5
    ) *
      1e5,
    labels = scales::label_number(suffix = " K", scale = 1e-3),
    expand = c(0, 0)
  ) +
  scale_color_manual(
    values = c(
      "Wheat" = "#F2C94C",
      "Barley" = "#5A9C5A",
      "Oats" = "#A68A64",
      "Maize" = "#E85C2A"
    )
  ) +
  lemon::coord_capped_cart(
    bottom = "none",
    left = "none"
  ) +
  labs(
    title = "New Zealand’s Cereal Yields Over Time: A Comparative Analysis of Wheat, Barley, Maize, and Oats",
    subtitle = "How have New Zealand’s wheat, barley, maize, and oats yields evolved since 1935? An introduction to crop-specific trends and insights.",
    caption = 'Author: Fabien Haury | Source: #Tidytuesday 2026-02-17',
    x = "Year",
    y = "Total yield (Tonnes)"
  ) +
  theme_global() +
  theme_creme() +
  guides(color = "none")

# sauvegarder_graphique_ggplot(
#   plt,
#   "2026-02-17",
#   "graph_crops_all.png",
#   25,
#   20,
#   300,
#   forcer = TRUE
# )

## Detailled Crops data ----
### Wheat data ----
### Data prep
wheat_sown <- df |>
  filter(measure == "Wheat (area sown)", ignore.case = TRUE) |>
  complete(
    year_ended_june = full_seq(year_ended_june, period = 1),
    fill = list(measure = "Wheat (area sown)")
  ) |>
  select(-c(value_label, decade))

wheat_yield <- df |>
  filter(measure == "Wheat (yield)", ignore.case = TRUE) |>
  complete(
    year_ended_june = full_seq(year_ended_june, period = 1),
    fill = list(measure = "Wheat (yield)")
  ) |>
  select(-c(value_label, decade))

wheat_harvest <- df |>
  filter(measure == "Wheat (area harvested)", ignore.case = TRUE) |>
  complete(
    year_ended_june = full_seq(year_ended_june, period = 1),
    fill = list(measure = "Wheat (area harvested)")
  ) |>
  select(-c(value_label, decade))

wheat_sown_harv <- rbind(wheat_sown, wheat_harvest)

### wheat yield
plt1 <- wheat_yield |>
  ggplot(aes(
    x = year_ended_june,
    y = value,
    group = measure,
    colour = measure,
  )) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 1, alpha = 0.75) +
  scale_x_continuous(
    limits = c(1935, 2025),
    breaks = seq(1935, 2025, 5),
    expand = c(0.01, 0.01)
  ) +
  scale_y_continuous(
    limits = c(0, ceiling(max(wheat_yield$value, na.rm = TRUE) / 5e4) * 5e4),
    breaks = seq(
      0,
      ceiling(max(wheat_yield$value, na.rm = TRUE) / 5e4) * 5e4,
      by = 5e4
    ),
    labels = scales::label_number(suffix = " K", scale = 1e-3),
    expand = c(0, 0)
  ) +
  scale_color_manual(
    values = c(
      "Wheat (yield)" = "#F2C94C"
    )
  ) +
  lemon::coord_capped_cart(
    bottom = "none",
    left = "none"
  ) +
  labs(
    title = "Wheat yield",
    x = NULL,
    y = "Yield (Tonnes)"
  ) +
  theme_global() +
  theme(
    legend.position = c(0.95, 0.10),
    legend.background = element_rect(fill = "white", color = "black")
  )

### wheat sown/harvested
my_colors <- c(
  "Wheat (area sown)" = "#3b528b",
  "Wheat (area harvested)" = "#f8768d"
)

plt2 <- wheat_sown_harv |>
  ggplot(aes(
    x = year_ended_june,
    y = value,
    group = measure,
    colour = measure,
  )) +
  geom_vline(aes(xintercept = 2003), alpha = 0.3, color = "purple") +
  geom_richtext(
    aes(
      x = 2003,
      y = 120000,
      label = "From <b>2003</b>: <span style='color:#f8768d'><i>area harvested</i></span> replaced<br/> 
            <span style='color:#3b528b'><i>area sown</i></span> as the <b>standard</b> measure."
    ),
    color = "black",
    label.color = NA,
    family = "Verdana"
  ) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 1, alpha = 0.75) +
  scale_x_continuous(
    limits = c(1935, 2025),
    breaks = seq(1935, 2025, 5),
    expand = c(0.01, 0.01)
  ) +
  scale_y_continuous(
    limits = c(
      0,
      ceiling(max(wheat_sown_harv$value, na.rm = TRUE) / 1e4) * 1e4
    ),
    breaks = seq(
      0,
      ceiling(max(wheat_sown_harv$value, na.rm = TRUE) / 1e4) * 1e4,
      by = 1e4
    ),
    labels = scales::label_number(suffix = " K", scale = 1e-3),
    expand = c(0, 0)
  ) +
  scale_color_manual(values = my_colors) +
  lemon::coord_capped_cart(
    bottom = "none",
    left = "none"
  ) +
  labs(
    title = "Wheat area sown and harvested",
    x = "Year",
    y = "Area (Hectares)"
  ) +
  theme_global() +
  theme(
    legend.position = c(0.95, 0.90),
    legend.background = element_rect(fill = "white", color = "black")
  )

plt <- (plt1 / plt2) +
  plot_annotation(
    title = 'Wheat Production Trends in New Zealand (1935–2024)',
    subtitle = 'Analysis of sown area, harvested area, and yield over a century',
    caption = 'Author: Fabien Haury | Source: #Tidytuesday 2026-02-17',
    theme = theme(
      plot.title = element_text(
        family = "Verdana",
        face = "bold",
        size = 18,
        colour = "black",
        hjust = 0.5
      ),
      plot.subtitle = element_text(
        family = "Verdana",
        face = "plain",
        size = 12,
        colour = "grey10",
        hjust = 0.5
      ),
      plot.caption = element_text(
        family = "Verdana",
        face = "plain",
        size = 10,
        colour = "grey20",
        hjust = 1
      )
    )
  )

# sauvegarder_graphique_ggplot(
#   plt,
#   "2026-02-17",
#   "graph_crops_wheat.png",
#   25,
#   20,
#   300,
#   forcer = TRUE
# )

### Barley data ----
### Data prep
barley_sown <- df |>
  filter(measure == "Barley (area sown)", ignore.case = TRUE) |>
  complete(
    year_ended_june = full_seq(year_ended_june, period = 1),
    fill = list(measure = "Barley (area sown)")
  ) |>
  select(-c(value_label, decade))

barley_yield <- df |>
  filter(measure == "Barley (yield)", ignore.case = TRUE) |>
  complete(
    year_ended_june = full_seq(year_ended_june, period = 1),
    fill = list(measure = "Barley (yield)")
  ) |>
  select(-c(value_label, decade))

barley_harvest <- df |>
  filter(measure == "Barley (area harvested)", ignore.case = TRUE) |>
  complete(
    year_ended_june = full_seq(year_ended_june, period = 1),
    fill = list(measure = "Barley (area harvested)")
  ) |>
  select(-c(value_label, decade))

barley_sown_harv <- rbind(barley_sown, barley_harvest)

### Barley yield
plt1 <- barley_yield |>
  ggplot(aes(
    x = year_ended_june,
    y = value,
    group = measure,
    colour = measure,
  )) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 1, alpha = 0.75) +
  scale_x_continuous(
    limits = c(1935, 2025),
    breaks = seq(1935, 2025, 5),
    expand = c(0.01, 0.01)
  ) +
  scale_y_continuous(
    limits = c(0, ceiling(max(barley_yield$value, na.rm = TRUE) / 5e4) * 5e4),
    breaks = seq(
      0,
      ceiling(max(barley_yield$value, na.rm = TRUE) / 5e4) * 5e4,
      by = 5e4
    ),
    labels = scales::label_number(suffix = " K", scale = 1e-3),
    expand = c(0, 0)
  ) +
  scale_color_manual(
    values = c(
      "Barley (yield)" = "#5A9C5A"
    )
  ) +
  lemon::coord_capped_cart(
    bottom = "none",
    left = "none"
  ) +
  labs(
    title = "Barley yield",
    x = NULL,
    y = "Yield (Tonnes)"
  ) +
  theme_global() +
  theme(
    legend.position = c(0.95, 0.10),
    legend.background = element_rect(fill = "white", color = "black")
  )

### barley sown/harvested
my_colors <- c(
  "Barley (area sown)" = "#3b528b",
  "Barley (area harvested)" = "#f8768d"
)

plt2 <- barley_sown_harv |>
  ggplot(aes(
    x = year_ended_june,
    y = value,
    group = measure,
    colour = measure,
  )) +
  geom_vline(aes(xintercept = 2003), alpha = 0.3, color = "purple") +
  geom_richtext(
    aes(
      x = 2003,
      y = 120000,
      label = "From <b>2003</b>: <span style='color:#f8768d'><i>area harvested</i></span> replaced<br/> 
            <span style='color:#3b528b'><i>area sown</i></span> as the <b>standard</b> measure."
    ),
    color = "black",
    label.color = NA,
    family = "Verdana"
  ) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 1, alpha = 0.75) +
  scale_x_continuous(
    limits = c(1935, 2025),
    breaks = seq(1935, 2025, 5),
    expand = c(0.01, 0.01)
  ) +
  scale_y_continuous(
    limits = c(
      0,
      ceiling(max(barley_sown_harv$value, na.rm = TRUE) / 1e4) * 1e4
    ),
    breaks = seq(
      0,
      ceiling(max(barley_sown_harv$value, na.rm = TRUE) / 1e4) * 1e4,
      by = 1e4
    ),
    labels = scales::label_number(suffix = " K", scale = 1e-3),
    expand = c(0, 0)
  ) +
  scale_color_manual(values = my_colors) +
  lemon::coord_capped_cart(
    bottom = "none",
    left = "none"
  ) +
  labs(
    title = "Barley area sown and harvested",
    x = "Year",
    y = "Area (Hectares)"
  ) +
  theme_global() +
  theme(
    legend.position = c(0.95, 0.90),
    legend.background = element_rect(fill = "white", color = "black")
  )

plt <- (plt1 / plt2) +
  plot_annotation(
    title = 'Barley Production Trends in New Zealand (1935–2024)',
    subtitle = 'Analysis of sown area, harvested area, and yield over a century',
    caption = 'Author: Fabien Haury | Source: #Tidytuesday 2026-02-17',
    theme = theme(
      plot.title = element_text(
        family = "Verdana",
        face = "bold",
        size = 18,
        colour = "black",
        hjust = 0.5
      ),
      plot.subtitle = element_text(
        family = "Verdana",
        face = "plain",
        size = 12,
        colour = "grey10",
        hjust = 0.5
      ),
      plot.caption = element_text(
        family = "Verdana",
        face = "plain",
        size = 10,
        colour = "grey20",
        hjust = 1
      )
    )
  )

# sauvegarder_graphique_ggplot(
#   plt,
#   "2026-02-17",
#   "graph_crops_barley.png",
#   25,
#   20,
#   300,
#   forcer = TRUE
# )

### Maize data ----
### Data prep
maize_sown <- df |>
  filter(measure == "Maize (area sown)", ignore.case = TRUE) |>
  complete(
    year_ended_june = full_seq(year_ended_june, period = 1),
    fill = list(measure = "Maize (area sown)")
  ) |>
  select(-c(value_label, decade))

maize_yield <- df |>
  filter(measure == "Maize (yield)", ignore.case = TRUE) |>
  complete(
    year_ended_june = full_seq(year_ended_june, period = 1),
    fill = list(measure = "Maize (yield)")
  ) |>
  select(-c(value_label, decade))

### Maize yield
plt1 <- maize_yield |>
  ggplot(aes(
    x = year_ended_june,
    y = value,
    group = measure,
    colour = measure,
  )) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 1, alpha = 0.75) +
  scale_x_continuous(
    limits = c(1935, 2025),
    breaks = seq(1935, 2025, 5),
    expand = c(0.01, 0.01)
  ) +
  scale_y_continuous(
    limits = c(0, ceiling(max(maize_yield$value, na.rm = TRUE) / 5e4) * 5e4),
    breaks = seq(
      0,
      ceiling(max(maize_yield$value, na.rm = TRUE) / 5e4) * 5e4,
      by = 5e4
    ),
    labels = scales::label_number(suffix = " K", scale = 1e-3),
    expand = c(0, 0)
  ) +
  scale_color_manual(
    values = c(
      "Maize (yield)" = "#E85C2A"
    )
  ) +
  lemon::coord_capped_cart(
    bottom = "none",
    left = "none"
  ) +
  labs(
    title = "Maize yield",
    x = NULL,
    y = "Yield (Tonnes)"
  ) +
  theme_global() +
  theme(
    legend.position = c(0.95, 0.10),
    legend.background = element_rect(fill = "white", color = "black")
  )

### Maize sown
my_colors <- c(
  "Maize (area sown)" = "#3b528b"
)

plt2 <- maize_sown |>
  ggplot(aes(
    x = year_ended_june,
    y = value,
    group = measure,
    colour = measure,
  )) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 1, alpha = 0.75) +
  scale_x_continuous(
    limits = c(1935, 2025),
    breaks = seq(1935, 2025, 5),
    expand = c(0.01, 0.01)
  ) +
  scale_y_continuous(
    limits = c(
      0,
      ceiling(max(maize_sown$value, na.rm = TRUE) / 1e4) * 1e4
    ),
    breaks = seq(
      0,
      ceiling(max(maize_sown$value, na.rm = TRUE) / 1e4) * 1e4,
      by = 1e4
    ),
    labels = scales::label_number(suffix = " K", scale = 1e-3),
    expand = c(0, 0)
  ) +
  scale_color_manual(values = my_colors) +
  lemon::coord_capped_cart(
    bottom = "none",
    left = "none"
  ) +
  labs(
    title = "Maize area sown",
    x = "Year",
    y = "Area (Hectares)"
  ) +
  theme_global() +
  theme(
    legend.position = c(0.95, 0.90),
    legend.background = element_rect(fill = "white", color = "black")
  )

plt <- (plt1 / plt2) +
  plot_annotation(
    title = 'Maize Production Trends in New Zealand (1935–2024)',
    subtitle = 'Analysis of sown area, and yield over a century',
    caption = 'Author: Fabien Haury | Source: #Tidytuesday 2026-02-17',
    theme = theme(
      plot.title = element_text(
        family = "Verdana",
        face = "bold",
        size = 18,
        colour = "black",
        hjust = 0.5
      ),
      plot.subtitle = element_text(
        family = "Verdana",
        face = "plain",
        size = 12,
        colour = "grey10",
        hjust = 0.5
      ),
      plot.caption = element_text(
        family = "Verdana",
        face = "plain",
        size = 10,
        colour = "grey20",
        hjust = 1
      )
    )
  )

# sauvegarder_graphique_ggplot(
#   plt,
#   "2026-02-17",
#   "graph_crops_maize.png",
#   25,
#   20,
#   300,
#   forcer = TRUE
# )

### Oats data ----
### Data prep
oats_sown <- df |>
  filter(measure == "Oats (area sown)", ignore.case = TRUE) |>
  complete(
    year_ended_june = full_seq(year_ended_june, period = 1),
    fill = list(measure = "Oats (area sown)")
  ) |>
  select(-c(value_label, decade))

oats_yield <- df |>
  filter(measure == "Oats (yield)", ignore.case = TRUE) |>
  complete(
    year_ended_june = full_seq(year_ended_june, period = 1),
    fill = list(measure = "Oats (yield)")
  ) |>
  select(-c(value_label, decade))

### oats yield
plt1 <- oats_yield |>
  ggplot(aes(
    x = year_ended_june,
    y = value,
    group = measure,
    colour = measure,
  )) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 1, alpha = 0.75) +
  scale_x_continuous(
    limits = c(1935, 2025),
    breaks = seq(1935, 2025, 5),
    expand = c(0.01, 0.01)
  ) +
  scale_y_continuous(
    limits = c(0, ceiling(max(oats_yield$value, na.rm = TRUE) / 5e3) * 5e3),
    breaks = seq(
      0,
      ceiling(max(oats_yield$value, na.rm = TRUE) / 5e3) * 5e3,
      by = 10e3
    ),
    labels = scales::label_number(suffix = " K", scale = 1e-3),
    expand = c(0, 0)
  ) +
  scale_color_manual(
    values = c(
      "Oats (yield)" = "#A68A64"
    )
  ) +
  lemon::coord_capped_cart(
    bottom = "none",
    left = "none"
  ) +
  labs(
    title = "Oats yield",
    x = NULL,
    y = "Yield (Tonnes)"
  ) +
  theme_global() +
  theme(
    legend.position = c(0.95, 0.10),
    legend.background = element_rect(fill = "white", color = "black")
  )

### Oats sown
my_colors <- c(
  "Oats (area sown)" = "#3b528b"
)

plt2 <- oats_sown |>
  ggplot(aes(
    x = year_ended_june,
    y = value,
    group = measure,
    colour = measure,
  )) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 1, alpha = 0.75) +
  scale_x_continuous(
    limits = c(1935, 2025),
    breaks = seq(1935, 2025, 5),
    expand = c(0.01, 0.01)
  ) +
  scale_y_continuous(
    limits = c(0, ceiling(max(oats_sown$value, na.rm = TRUE) / 5e3) * 5e3),
    breaks = seq(
      0,
      ceiling(max(oats_sown$value, na.rm = TRUE) / 5e3) * 5e3,
      by = 5e3
    ),
    labels = scales::label_number(suffix = " K", scale = 1e-3),
    expand = c(0, 0)
  ) +
  scale_color_manual(values = my_colors) +
  lemon::coord_capped_cart(
    bottom = "none",
    left = "none"
  ) +
  labs(
    title = "Oats area sown",
    x = "Year",
    y = "Area (Hectares)"
  ) +
  theme_global() +
  theme(
    legend.position = c(0.95, 0.90),
    legend.background = element_rect(fill = "white", color = "black")
  )

plt <- (plt1 / plt2) +
  plot_annotation(
    title = 'Oats Production Trends in New Zealand (1935–2024)',
    subtitle = 'Analysis of sown area, and yield over a century',
    caption = 'Author: Fabien Haury | Source: #Tidytuesday 2026-02-17',
    theme = theme(
      plot.title = element_text(
        family = "Verdana",
        face = "bold",
        size = 18,
        colour = "black",
        hjust = 0.5
      ),
      plot.subtitle = element_text(
        family = "Verdana",
        face = "plain",
        size = 12,
        colour = "grey10",
        hjust = 0.5
      ),
      plot.caption = element_text(
        family = "Verdana",
        face = "plain",
        size = 10,
        colour = "grey20",
        hjust = 1
      )
    )
  )

# sauvegarder_graphique_ggplot(
#   plt,
#   "2026-02-17",
#   "graph_crops_oats.png",
#   25,
#   20,
#   300,
#   forcer = TRUE
# )

## Total Area of Farms ----
total_area_farm <- df |>
  filter(measure == "Total Area of Farms") |>
  complete(
    year_ended_june = full_seq(year_ended_june, period = 1),
    fill = list(measure = "Total Area of Farms")
  ) |>
  select(-c(measure, value_label, decade))

plt <- total_area_farm |>
  ggplot(aes(year_ended_june, value)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 1, alpha = 0.75) +
  scale_x_continuous(
    limits = c(1935, 2025),
    breaks = seq(1935, 2025, 5),
    expand = c(0.01, 0.01)
  ) +
  scale_y_continuous(
    limits = c(
      0,
      ceiling(max(total_area_farm$value, na.rm = TRUE) / 5e6) * 5e6
    ),
    breaks = seq(
      0,
      ceiling(max(total_area_farm$value, na.rm = TRUE) / 5e6) * 5e6,
      by = 2.5e6
    ),
    labels = scales::label_number(suffix = " M", scale = 1e-6),
    expand = c(0, 0)
  ) +
  lemon::coord_capped_cart(
    bottom = 'none',
    left = "none",
    right = "none"
  ) +
  labs(
    title = 'Long‐Term Trends in New Zealand’s Farm Area (1935–2024)',
    subtitle = 'Annual estimates of total farming surface compiled from national data.',
    caption = 'Author: Fabien Haury | Source: #Tidytuesday 2026-02-17',
    x = "Year",
    y = "Total area of farms (hectares)"
  ) +
  theme_global()

# sauvegarder_graphique_ggplot(
#   plt,
#   "2026-02-17",
#   "graph_farm_area.png",
#   25,
#   20,
#   300,
#   forcer = TRUE
# )

## Living Stocks data ----
### Total cattle ----
df_tot_cattle <- df |>
  filter(measure == "Total Cattle") |>
  complete(
    year_ended_june = full_seq(year_ended_june, period = 1),
    fill = list(value = NA)
  ) |>
  mutate(decade = paste0(floor(year_ended_june / 10) * 10, "s")) |>
  select(-c(measure, value_label))


plt <- ggplot(df_tot_cattle, aes(year_ended_june, value)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 1, alpha = 0.75) +
  scale_x_continuous(
    limits = c(1935, 2025),
    breaks = seq(1935, 2025, 5),
    expand = c(0.01, 0.01)
  ) +
  scale_y_continuous(
    limits = c(
      0,
      ceiling(max(df_tot_cattle$value, na.rm = TRUE) / 1e6) * 1e6
    ),
    breaks = seq(
      0,
      ceiling(max(df_tot_cattle$value, na.rm = TRUE) / 1e6) * 1e6,
      by = 1e6
    ),
    labels = scales::label_number(suffix = " M", scale = 1e-6),
    expand = c(0, 0)
  ) +
  lemon::coord_capped_cart(
    bottom = 'none',
    left = "none",
    right = "none"
  ) +
  labs(
    title = "Long-term trends in Cattle numbers in New Zealand",
    subtitle = "Annual totals reveal changing pressures in livestock production, 1935–2024",
    caption = "Author: Fabien Haury | Source: #Tidytuesday 2026-02-17",
    x = "Year",
    y = "Number of cattles"
  ) +
  theme_global()

# sauvegarder_graphique_ggplot(
#   plt,
#   "2026-02-17",
#   "graph_stocks_cattle.png",
#   25,
#   20,
#   300,
#   forcer = TRUE
# )

### Total pigs ----
df_tot_pigs <- df |>
  filter(measure == "Total Pigs") |>
  complete(
    year_ended_june = full_seq(year_ended_june, period = 1),
    fill = list(value = NA)
  ) |>
  mutate(decade = paste0(floor(year_ended_june / 10) * 10, "s")) |>
  select(-c(measure, value_label))


plt <- ggplot(df_tot_pigs, aes(year_ended_june, value)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 1, alpha = 0.75) +
  scale_x_continuous(
    limits = c(1935, 2025),
    breaks = seq(1935, 2025, 5),
    expand = c(0.01, 0.01)
  ) +
  scale_y_continuous(
    limits = c(0, ceiling(max(df_tot_pigs$value, na.rm = TRUE) / 5e4) * 5e4),
    breaks = seq(
      0,
      ceiling(max(df_tot_pigs$value, na.rm = TRUE) / 4e4) * 5e4,
      by = 5e4
    ),
    labels = scales::label_number(suffix = " K", scale = 1e-3),
    expand = c(0, 0)
  ) +
  lemon::coord_capped_cart(
    bottom = 'none',
    left = "none",
    right = "none"
  ) +
  labs(
    title = "Long-term trends in Pig numbers in New Zealand",
    subtitle = "Annual totals reveal changing pressures in livestock production, 1935–2024",
    caption = "Author: Fabien Haury | Source: #Tidytuesday 2026-02-17",
    x = "Year",
    y = "Number of pigs"
  ) +
  theme_global()

# sauvegarder_graphique_ggplot(
#   plt,
#   "2026-02-17",
#   "graph_stocks_pig.png",
#   25,
#   20,
#   300,
#   forcer = TRUE
# )

### Total sheeps ----
df_tot_sheep <- df |>
  filter(measure == "Total Sheep") |>
  complete(
    year_ended_june = full_seq(year_ended_june, period = 1),
    fill = list(value = NA)
  ) |>
  mutate(decade = paste0(floor(year_ended_june / 10) * 10, "s")) |>
  select(-c(measure, value_label))


plt <- ggplot(df_tot_sheep, aes(year_ended_june, value)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 1, alpha = 0.75) +
  scale_x_continuous(
    limits = c(1935, 2025),
    breaks = seq(1935, 2025, 5),
    expand = c(0.01, 0.01)
  ) +
  scale_y_continuous(
    limits = c(0, ceiling(max(df_tot_sheep$value, na.rm = TRUE) / 10e6) * 10e6),
    breaks = seq(
      0,
      ceiling(max(df_tot_sheep$value, na.rm = TRUE) / 5e6) * 5e6,
      by = 5e6
    ),
    labels = scales::label_number(suffix = " M", scale = 1e-6),
    expand = c(0, 0)
  ) +
  lemon::coord_capped_cart(
    bottom = 'none',
    left = "none",
    right = "none"
  ) +
  labs(
    title = "Long-term trends in Sheep numbers in New Zealand",
    subtitle = "Annual totals reveal changing pressures in livestock production, 1935–2024",
    caption = "Author: Fabien Haury | Source: #Tidytuesday 2026-02-17",
    x = "Year",
    y = "Number of sheep"
  ) +
  theme_global()

# sauvegarder_graphique_ggplot(
#   plt,
#   "2026-02-17",
#   "graph_stocks_sheep.png",
#   25,
#   20,
#   300,
#   forcer = TRUE
# )

### Total goats ----
df_tot_goats <- df |>
  filter(measure == "Total goats") |>
  complete(
    year_ended_june = full_seq(year_ended_june, period = 1),
    fill = list(value = NA)
  ) |>
  mutate(decade = paste0(floor(year_ended_june / 10) * 10, "s")) |>
  select(-c(measure, value_label))


plt <- ggplot(df_tot_goats, aes(year_ended_june, value)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 1, alpha = 0.75) +
  scale_x_continuous(
    limits = c(1935, 2025),
    breaks = seq(1935, 2025, 5),
    expand = c(0.01, 0.01)
  ) +
  scale_y_continuous(
    limits = c(
      0,
      ceiling(max(df_tot_goats$value, na.rm = TRUE) / 0.5e6) * 0.5e6
    ),
    breaks = seq(
      0,
      ceiling(max(df_tot_goats$value, na.rm = TRUE) / 1e6) * 1e6,
      by = 2.5e5
    ),
    labels = scales::label_number(suffix = " M", scale = 1e-6),
    expand = c(0, 0)
  ) +
  lemon::coord_capped_cart(
    bottom = 'none',
    left = "none",
    right = "none"
  ) +
  labs(
    title = "Long-term trends in Goat numbers in New Zealand",
    subtitle = "Annual totals reveal changing pressures in livestock production, 1935–2024",
    caption = "Author: Fabien Haury | Source: #Tidytuesday 2026-02-17",
    x = "Year",
    y = "Number of goats"
  ) +
  theme_global()

# sauvegarder_graphique_ggplot(
#   plt,
#   "2026-02-17",
#   "graph_stocks_goats.png",
#   25,
#   20,
#   300,
#   forcer = TRUE
# )

### Total deers ----
df_tot_deer <- df |>
  filter(measure == "Total Deer") |>
  complete(
    year_ended_june = full_seq(year_ended_june, period = 1),
    fill = list(value = NA)
  ) |>
  mutate(decade = paste0(floor(year_ended_june / 10) * 10, "s")) |>
  select(-c(measure, value_label))


plt <- ggplot(df_tot_deer, aes(year_ended_june, value)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 1, alpha = 0.75) +
  scale_x_continuous(
    limits = c(1935, 2025),
    breaks = seq(1935, 2025, 5),
    expand = c(0.01, 0.01)
  ) +
  scale_y_continuous(
    limits = c(0, ceiling(max(df_tot_deer$value, na.rm = TRUE) / 1e6) * 1e6),
    breaks = seq(
      0,
      ceiling(max(df_tot_deer$value, na.rm = TRUE) / 1e6) * 1e6,
      by = 2.5e5
    ),
    labels = scales::label_number(suffix = " M", scale = 1e-6),
    expand = c(0, 0)
  ) +
  lemon::coord_capped_cart(
    bottom = 'none',
    left = "none",
    right = "none"
  ) +
  labs(
    title = "Long-term trends in Deer numbers in New Zealand",
    subtitle = "Annual totals reveal changing pressures in livestock production, 1935–2024",
    caption = "Author: Fabien Haury | Source: #Tidytuesday 2026-02-17",
    x = "Year",
    y = "Number of goats"
  ) +
  theme_global()

# sauvegarder_graphique_ggplot(
#   plt,
#   "2026-02-17",
#   "graph_stocks_deer.png",
#   25,
#   20,
#   300,
#   forcer = TRUE
# )

### Total poultry ----
df_tot_poultry <- df |>
  filter(measure == "Total poultry") |>
  complete(
    year_ended_june = full_seq(year_ended_june, period = 1),
    fill = list(value = NA)
  ) |>
  mutate(decade = paste0(floor(year_ended_june / 10) * 10, "s")) |>
  select(-c(measure, value_label))


plt <- ggplot(df_tot_poultry, aes(year_ended_june, value)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 1, alpha = 0.75) +
  scale_x_continuous(
    limits = c(1935, 2025),
    breaks = seq(1935, 2025, 5),
    expand = c(0.01, 0.01)
  ) +
  scale_y_continuous(
    limits = c(0, ceiling(max(df_tot_poultry$value, na.rm = TRUE) / 5e6) * 5e6),
    breaks = seq(
      0,
      ceiling(max(df_tot_poultry$value, na.rm = TRUE) / 5e6) * 5e6,
      by = 5e6
    ),
    labels = scales::label_number(suffix = " M", scale = 1e-6),
    expand = c(0, 0)
  ) +
  lemon::coord_capped_cart(
    bottom = 'none',
    left = "none",
    right = "none"
  ) +
  labs(
    title = "Long-term trends in Poultry numbers in New Zealand",
    subtitle = "Annual totals reveal changing pressures in livestock production, 1935–2024",
    caption = "Author: Fabien Haury | Source: #Tidytuesday 2026-02-17",
    x = "Year",
    y = "Number of goats"
  ) +
  theme_global()

# sauvegarder_graphique_ggplot(
#   plt,
#   "2026-02-17",
#   "graph_stocks_poultry.png",
#   25,
#   20,
#   300,
#   forcer = TRUE
# )
