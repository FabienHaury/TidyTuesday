# Load global settings
source("~/R things/Tidytuesday/global_settings.R")

# Load additional required libraries
library(dplyr)
library(tidyverse)
library(tidytuesdayR)
library(lubridate)
library(gt, quietly = TRUE)
library(forcats)
library(scales)

# Load data
tuesdata <- tidytuesdayR::tt_load(2025, week = 34)

# Get data id needed
billboard <- tuesdata$billboard
topics <- tuesdata$topics


# Remove tuesdata
rm(tuesdata)


################################ Data Wrangling ################################
## Création décennie
billboard <- billboard |>
  mutate(
    year = year(date),
    decade = case_when(
      year >= 1950 & year < 1960 ~ "1950",
      year >= 1960 & year < 1970 ~ "1960",
      year >= 1970 & year < 1980 ~ "1970",
      year >= 1980 & year < 1990 ~ "1980",
      year >= 1990 & year < 2000 ~ "1990",
      year >= 2000 & year < 2010 ~ "2000",
      year >= 2010 & year < 2020 ~ "2010",
      TRUE ~ "2020"
    )
  )


## Remplacer NA pour talent_contestant
billboard <- billboard |>
  mutate(
    talent_contestant = replace(
      talent_contestant,
      is.na(talent_contestant),
      "None"
    )
  )


################################ Tableaux ################################
# Tableaux
## Tableau classant les apparences des maisons mère et sous-label groupés par maison mère et par décade.
billboard2 <- billboard |>
  select(parent_label, label, decade) |>
  mutate(decade = factor(decade, levels = sort(unique(decade))))

decade_cols <- levels(billboard2$decade)

tableau <- billboard2 |>
  count(parent_label, label, decade) |>
  pivot_wider(
    names_from = decade,
    values_from = n,
    values_fill = 0
  ) %>%
  mutate(Total = rowSums(select(., all_of(decade_cols))))

tab_parent_label <- tableau |>
  gt(rowname_col = "label", groupname_col = "parent_label") |>
  tab_spanner(
    label = "Decade",
    columns = all_of(decade_cols)
  ) |>
  tab_header(
    title = "Ranking by label and decade",
    subtitle = "Billboard data grouped by record label"
  ) |>
  fmt_number(columns = c(all_of(decade_cols), Total), decimals = 0) |>
  data_color(
    columns = all_of(decade_cols),
    colors = scales::col_numeric(
      palette = c("#FFFFE0", "#FFA500", "#FF0000"),
      domain = range(tableau[, decade_cols], na.rm = TRUE)
    )
  ) |>
  cols_align(align = "right", columns = c(all_of(decade_cols), Total)) |>
  cols_align(
    align = "center",
    columns = c("1950", "1960", "1970", "1980", "1990", "2000", "2010", "2020")
  ) |>
  tab_style(
    style = cell_borders(
      sides = "left",
      color = "lightgray",
      weight = px(2)
    ),
    locations = cells_body(columns = Total)
  ) |>
  tab_options(
    table.margin.left = "2px",
    table.margin.right = "2px"
  ) |>
  tab_source_note("Colors represent the number of hits per decade.")


sauvegarder_tableau_gt(
  tab_parent_label,
  "2025-08-26",
  "tab_parent_label.png"
)


## Tableau classant les artistes apparaissant le plus dans le billboard, ainsi que la durée moyenne de leur rank 1.
tab_artist <- billboard |>
  group_by(artist) |>
  summarise(
    Nb_appearance = n(),
    avg_length_top_one = mean(weeks_at_number_one, na.rm = TRUE),
    avg_rating = mean(overall_rating, na.rm = TRUE)
  ) |>
  arrange(desc(Nb_appearance)) |>
  gt() |>
  cols_label(
    artist = "Artist",
    Nb_appearance = "Number of appearances",
    avg_length_top_one = "Average duration at #1 (weeks)",
    avg_rating = "Average rating"
  ) |>
  tab_header(
    title = "Billboard Artist Ranking",
    subtitle = "Number of appearances and average duration at number one"
  ) |>
  fmt_number(
    columns = c("Nb_appearance", "avg_length_top_one", "avg_rating"),
    decimals = 0
  ) |>
  data_color(
    columns = c("Nb_appearance"),
    colors = scales::col_numeric(
      palette = c("#FFFFE0", "#FFA500", "#FF0000"),
      domain = NULL
    )
  ) |>
  data_color(
    columns = c("avg_length_top_one"),
    colors = scales::col_numeric(
      palette = c("#d9f0d3", "#31a354", "#028529ff"),
      domain = NULL
    )
  ) |>
  data_color(
    columns = c("avg_rating"),
    colors = scales::col_numeric(
      palette = c("#E6E6FA", "#9370DB", "#4B0082"),
      domain = NULL
    )
  ) |>
  cols_align(
    align = "center",
    columns = c("Nb_appearance", "avg_length_top_one", "avg_rating")
  ) |>
  cols_width(
    artist ~ px(200),
    Nb_appearance ~ px(150),
    avg_length_top_one ~ px(150),
    avg_rating ~ px(150)
  ) |>
  tab_style(
    style = cell_text(whitespace = "normal"),
    locations = cells_body(columns = "artist")
  ) |>
  tab_style(
    style = cell_text(align = "center"),
    locations = cells_column_labels(columns = everything())
  ) |>
  tab_options(
    table.margin.left = "2px",
    table.margin.right = "2px"
  )


sauvegarder_tableau_gt(tab_artist, "2025-08-26", "tab_artist.png")


## Analyse des sujet de paroles.
tab_lyrics <- billboard |>
  drop_na(lyrical_topic) |>
  group_by(lyrical_topic) |>
  summarise(
    Nb_appearances = n(),
    avg_duration_no1 = mean(weeks_at_number_one, na.rm = TRUE)
  ) |>
  arrange(desc(Nb_appearances)) |>
  gt() |>
  tab_header(
    title = "Analysis of Billboard Hit Themes",
    subtitle = "Frequency and average duration at number 1 by lyrical subject"
  ) |>
  fmt_number(
    columns = c("Nb_appearances", "avg_duration_no1"),
    decimals = 0
  ) |>
  cols_label(
    lyrical_topic = "Lyrical subject",
    Nb_appearances = "Number of appearances",
    avg_duration_no1 = "Average duration at #1 (weeks)"
  ) |>
  data_color(
    columns = c("Nb_appearances"),
    colors = scales::col_numeric(
      palette = c("#FFFFE0", "#FFA500", "#FF0000"),
      domain = NULL
    )
  ) |>
  data_color(
    columns = c("avg_duration_no1"),
    colors = scales::col_numeric(
      palette = c("#d9f0d3", "#31a354", "#028529ff"),
      domain = NULL
    )
  ) |>
  cols_align(
    align = "center",
    columns = c("Nb_appearances", "avg_duration_no1")
  ) |>
  cols_width(
    lyrical_topic ~ px(250),
    Nb_appearances ~ px(150),
    avg_duration_no1 ~ px(150)
  ) |>
  tab_style(
    style = cell_text(whitespace = "normal"),
    locations = cells_body(columns = "lyrical_topic")
  ) |>
  tab_style(
    style = cell_text(align = "center"),
    locations = cells_column_labels(columns = everything())
  ) |>
  tab_options(
    table.margin.left = "2px",
    table.margin.right = "2px"
  )


sauvegarder_tableau_gt(
  tab_parole,
  "2025-08-26",
  "tab_parole.png"
)


## tab top 10 paroles.
tab_top_10_lyrics <- billboard |>
  drop_na(lyrical_topic) |>
  group_by(lyrical_topic) |>
  summarise(
    Nb_appearances = n(),
    avg_duration_no1 = mean(weeks_at_number_one, na.rm = TRUE)
  ) |>
  slice_max(Nb_appearances, n = 10) |>
  arrange(desc(Nb_appearances)) |>
  gt() |>
  tab_header(
    title = "Top Billboard Hit Themes",
    subtitle = "Frequency and average duration at number 1 by lyrical subject"
  ) |>
  fmt_number(
    columns = c("Nb_appearances", "avg_duration_no1"),
    decimals = 0
  ) |>
  cols_label(
    lyrical_topic = "Lyrical subject",
    Nb_appearances = "Number of appearances",
    avg_duration_no1 = "Average duration at #1 (weeks)"
  ) |>
  data_color(
    columns = c("Nb_appearances"),
    colors = scales::col_numeric(
      palette = c("#FFFFE0", "#FFA500", "#FF0000"),
      domain = NULL
    )
  ) |>
  data_color(
    columns = c("avg_duration_no1"),
    colors = scales::col_numeric(
      palette = c("#d9f0d3", "#31a354", "#028529ff"),
      domain = NULL
    )
  ) |>
  cols_align(
    align = "center",
    columns = c("Nb_appearances", "avg_duration_no1")
  ) |>
  cols_width(
    lyrical_topic ~ px(200),
    Nb_appearances ~ px(150),
    avg_duration_no1 ~ px(150)
  ) |>
  tab_style(
    style = cell_text(whitespace = "normal"),
    locations = cells_body(columns = "lyrical_topic")
  ) |>
  tab_style(
    style = cell_text(align = "center"),
    locations = cells_column_labels(columns = everything())
  ) |>
  tab_options(
    table.margin.left = "2px",
    table.margin.right = "2px"
  )


sauvegarder_tableau_gt(
  tab_top_10_parole,
  "2025-08-26",
  "tab_top_10_parole.png"
)


## Résume par décade
summary_table <- billboard |>
  group_by(decade) |>
  summarise(
    Nb_appearance = n(),
    avg_rating = mean(overall_rating, na.rm = TRUE),
    avg_length_sec = mean(length_sec, na.rm = TRUE),
    avg_bpm = mean(bpm, na.rm = TRUE)
  ) |>
  arrange(decade)


tab_summary_decade <- summary_table |>
  gt() |>
  tab_header(
    title = "Analysis of Billboard Hits by Decade",
    subtitle = "Frequency of appearance, average rating, average duration and average BPM"
  ) |>
  fmt_number(
    columns = c(Nb_appearance, avg_length_sec, avg_bpm),
    decimals = 0
  ) |>
  fmt_number(
    columns = avg_rating,
    decimals = 2
  ) |>
  cols_label(
    decade = "Decade",
    Nb_appearance = "Number of appearances",
    avg_rating = "Average rating",
    avg_length_sec = "Average duration (sec)",
    avg_bpm = "Average BPM"
  ) |>
  data_color(
    columns = Nb_appearance,
    colors = scales::col_numeric(
      palette = c("#FFFFE0", "#FFA500", "#FF0000"),
      domain = range(summary_table$Nb_appearance, na.rm = TRUE)
    )
  ) |>
  data_color(
    columns = avg_length_sec,
    colors = scales::col_numeric(
      palette = c("#d9f0d3", "#31a354", "#028529ff"),
      domain = range(summary_table$avg_length_sec, na.rm = TRUE)
    )
  ) |>
  data_color(
    columns = avg_rating,
    colors = scales::col_numeric(
      palette = c("#E6E6FA", "#9370DB", "#4B0082"),
      domain = range(summary_table$avg_rating, na.rm = TRUE)
    )
  ) |>
  data_color(
    columns = avg_bpm,
    colors = scales::col_numeric(
      palette = c("#E6E6FA", "#7092dbff", "#0d0082ff"),
      domain = range(summary_table$avg_bpm, na.rm = TRUE)
    )
  ) |>
  cols_align(
    align = "center",
    columns = c(Nb_appearance, avg_rating, avg_length_sec, avg_bpm)
  ) |>
  cols_align(
    align = "left",
    columns = decade
  ) |>
  tab_options(
    table.margin.left = "2px",
    table.margin.right = "2px"
  )


sauvegarder_tableau_gt(
  tab_summary_decade,
  "2025-08-26",
  "tab_summary_decade.png"
)


## Moyenne top 1 pour les talent télé-crochet
billboard2 <- billboard |>
  group_by(decade, talent_contestant) |>
  summarise(avr_top_one = mean(weeks_at_number_one, na.rm = TRUE)) |>
  ungroup() |>
  mutate(decade = factor(decade, levels = sort(unique(decade))))

decade_cols <- levels(billboard2$decade)

tableau <- billboard2 |>
  pivot_wider(
    names_from = decade,
    values_from = avr_top_one,
    values_fill = 0
  )

color_domain <- range(tableau[, decade_cols], na.rm = TRUE)

tab_top_1_talent_contestant <- tableau |>
  gt() |>
  tab_header(
    title = md(
      "**Average weeks at #1 for talents revealed by TV contests by decade**"
    ),
    subtitle = md(
      "Analysis of Billboard performance of artists from television competitions, grouped by decade"
    )
  ) |>
  tab_spanner(
    label = "Decade",
    columns = all_of(decade_cols)
  ) |>
  fmt_number(
    columns = c("1950", "1960", "1970", "1980", "1990", "2000", "2010", "2020"),
    decimals = 0
  ) |>
  cols_align(
    align = "center",
    columns = c("1950", "1960", "1970", "1980", "1990", "2000", "2010", "2020")
  ) |>
  cols_label(
    talent_contestant = "TV talent show"
  ) |>
  tab_options(
    table.margin.left = "2px",
    table.margin.right = "2px"
  ) |>
  data_color(
    columns = all_of(decade_cols),
    colors = scales::col_numeric(
      palette = c("#E6E6FA", "#9370DB", "#4B0082"),
      domain = color_domain
    )
  )


sauvegarder_tableau_gt(
  tab_top_1_talent_contestant,
  "2025-08-26",
  "tab_top_1_talent_contestant.png"
)


## Top 10 parent_label
tableau <- billboard |>
  count(parent_label) |>
  slice_max(n, n = 10) |>
  arrange(desc(n))


tab_top_10_parent_label <- tableau |>
  gt() |>
  tab_header(
    title = "Top 10 Record Labels"
  ) |>
  cols_label(
    parent_label = "Record label",
    n = "Number of appearances"
  ) |>
  data_color(
    columns = c("n"),
    colors = scales::col_numeric(
      palette = c("#FFFFE0", "#FFA500", "#FF0000"),
      domain = range(tableau$n, na.rm = TRUE)
    )
  ) |>
  cols_align(
    align = "center",
    columns = c(n)
  )


sauvegarder_tableau_gt(
  tab_top_10_parent_label,
  "2025-08-26",
  "tab_top_10_parent_label.png"
)


## Top 10 label
tableau <- billboard |>
  count(label) |>
  slice_max(n, n = 10) |>
  arrange(desc(n))


tab_top_10_label <- tableau |>
  gt() |>
  tab_header(
    title = "Top 10 Labels"
  ) |>
  cols_label(
    label = "Label",
    n = "Number of appearances"
  ) |>
  data_color(
    columns = c("n"),
    colors = scales::col_numeric(
      palette = c("#FFFFE0", "#FFA500", "#FF0000"),
      domain = range(tableau$n, na.rm = TRUE)
    )
  ) |>
  cols_align(
    align = "center",
    columns = c(n)
  )

sauvegarder_tableau_gt(
  tab_top_10_label,
  "2025-08-26",
  "tab_top_10_label.png"
)

## Top 10 parent_label/label
tableau <- billboard |>
  count(parent_label, label) |>
  slice_max(n, n = 10) |>
  arrange(desc(n))


tab_top_10_parent_label_label <- tableau |>
  gt() |>
  tab_header(
    title = "Top 10 Record Labels and Sub-labels"
  ) |>
  cols_label(
    parent_label = "Record label",
    label = "Sub-label",
    n = "Number of appearances"
  ) |>
  data_color(
    columns = c("n"),
    colors = scales::col_numeric(
      palette = c("#FFFFE0", "#FFA500", "#FF0000"),
      domain = range(tableau$n, na.rm = TRUE)
    )
  ) |>
  cols_align(
    align = "center",
    columns = c(n)
  )

sauvegarder_tableau_gt(
  tab_top_10_parent_label_label,
  "2025-08-26",
  "tab_top_10_parent_label_label.png"
)


## Total label détenu par maison de disque
tableau <- billboard |>
  drop_na(parent_label) |>
  group_by(parent_label) |>
  summarise(count_unique = n_distinct(label, na.rm = TRUE)) |>
  arrange(desc(count_unique))


tab_label_detention <- tableau |>
  gt() |>
  tab_header(
    title = "Total Labels Owned by Record Label"
  ) |>
  cols_label(
    parent_label = "Record label",
    count_unique = "Total"
  ) |>
  data_color(
    columns = c("count_unique"),
    colors = scales::col_numeric(
      palette = c("#FFFFE0", "#FFA500", "#FF0000"),
      domain = range(tableau$count_unique, na.rm = TRUE)
    )
  ) |>
  cols_align(
    align = "center",
    columns = c("count_unique")
  ) |>
  cols_width(
    parent_label ~ px(250),
    count_unique ~ px(200)
  ) |>
  tab_style(
    style = cell_text(whitespace = "normal"),
    locations = cells_body(columns = "parent_label")
  )


sauvegarder_tableau_gt(
  tab_label_detention,
  "2025-08-26",
  "tab_label_detention.png"
)


################################ Graphiques################################
## Top 10 des artistes par total apparitions.
graph_top_10_artist <- billboard |>
  count(artist) |>
  slice_max(n, n = 10) |>
  mutate(artist = fct_reorder(artist, n, .desc = TRUE)) |>
  ggplot(aes(artist, n)) +
  geom_col(fill = "#FFA500", color = "black") +
  geom_text(aes(label = n), vjust = -0.5) +
  custom_theme() +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)
  ) +
  labs(
    title = "Top Most Frequent Artists",
    subtitle = "Including ties",
    x = "Artist",
    y = "Number of appearances"
  )

sauvegarder_graphique_ggplot(
  graph_top_10_artist,
  "2025-08-26",
  "graph_top_10_artist.png",
  10,
  10,
  400
)


## Bpm moyen par décade avec ligne de référence.
billboard_clean <- billboard |>
  drop_na(decade, bpm) |>
  group_by(decade) |>
  summarise(bpm_avg = as.integer(mean(bpm)))


global_mean <- mean(billboard_clean$bpm_avg)


upper <- max(billboard_clean$bpm_avg) + 10


graph_bpm_decade <- billboard_clean |>
  ggplot(aes(decade, bpm_avg)) +
  geom_col(fill = "#7092dbff", color = "black") +
  geom_text(aes(label = bpm_avg), vjust = -0.5, size = 6) +
  geom_hline(
    yintercept = global_mean,
    color = "red",
    linetype = "dashed"
  ) +
  scale_y_continuous(
    expand = c(0, 0),
    limits = c(0, upper),
    breaks = seq(0, upper, 10)
  ) +
  labs(
    title = "Average BPM by Decade",
    subtitle = paste(
      "Red line: global average (",
      round(global_mean),
      " BPM)",
      sep = ""
    ),
    x = "Decade",
    y = "Average BPM"
  ) +
  custom_theme() +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  )

sauvegarder_graphique_ggplot(
  graph_bpm_decade,
  "2025-08-26",
  "graph_bpm_decade.png",
  10,
  10,
  400
)


## Rating moyen par décade avec ligne de référence.
billboard_clean <- billboard |>
  drop_na(decade, overall_rating) |>
  group_by(decade) |>
  summarise(rating_avg = round(mean(overall_rating), 2))

global_mean <- mean(billboard_clean$rating_avg)

upper <- 10

graph_rating_decade <- ggplot(billboard_clean, aes(decade, rating_avg)) +
  geom_col(fill = "#9370DB", color = "black") +
  geom_text(aes(label = rating_avg), vjust = -0.5) +
  geom_hline(
    yintercept = global_mean,
    color = "red",
    linetype = "dashed"
  ) +
  scale_y_continuous(
    expand = c(0, 0),
    limits = c(0, upper),
    breaks = seq(0, upper, 1)
  ) +
  labs(
    title = "Average Rating by Decade",
    subtitle = paste(
      "Red line: global average (",
      round(global_mean, 2),
      ")",
      sep = ""
    ),
    x = "Decade",
    y = "Rating"
  ) +
  custom_theme() +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  )

sauvegarder_graphique_ggplot(
  graph_rating_decade,
  "2025-08-26",
  "graph_rating_decade.png",
  10,
  10,
  400
)


## Top 10 des pays d'origine
graph_top_10_origin <- billboard |>
  count(artist_place_of_origin) |>
  slice_max(n, n = 10) |>
  mutate(
    artist_place_of_origin = fct_reorder(
      artist_place_of_origin,
      n,
      .desc = TRUE
    )
  ) |>
  ggplot(aes(artist_place_of_origin, n)) +
  geom_col(fill = "#A6D3ED", color = "black") +
  geom_text(aes(label = n), vjust = -0.5) +
  labs(
    title = "Top Countries of Artist Origins",
    subtitle = "Including ties",
    x = "Country of origin",
    y = "Number of appearances"
  ) +
  custom_theme() +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)
  )

sauvegarder_graphique_ggplot(
  graph_top_10_origin,
  "2025-08-26",
  "graph_top_10_origine.png",
  10,
  10,
  400
)


## Durée moyenne par décade
billboard_clean <- billboard |>
  drop_na(decade, length_sec) |>
  group_by(decade) |>
  summarise(length_avg = round(mean(length_sec)))

global_mean <- mean(billboard_clean$length_avg)

upper <- ceiling(max(billboard_clean$length_avg) / 10) * 10

graph_length_decade <- ggplot(billboard_clean, aes(decade, length_avg)) +
  geom_col(fill = "#31a354", color = "black") +
  geom_text(aes(label = length_avg), vjust = -0.5) +
  geom_hline(
    yintercept = global_mean,
    color = "red",
    linetype = "dashed"
  ) +
  scale_y_continuous(
    expand = c(0, 0),
    limits = c(0, upper),
    breaks = seq(0, upper, 50)
  ) +
  labs(
    title = "Average Duration in Seconds by Decade",
    subtitle = paste(
      "Red line: global average (",
      round(global_mean),
      " sec)",
      sep = ""
    ),
    x = "Decade",
    y = "Duration (seconds)"
  ) +
  custom_theme() +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  )

sauvegarder_graphique_ggplot(
  graph_length_decade,
  "2025-08-26",
  "graph_length_decade.png",
  10,
  10,
  400
)


## Évolution de la note moyenne des hits Billboard
graph_rating_line <- billboard |>
  group_by(year) |>
  mutate(avg_rating = round(mean(overall_rating, na.rm = TRUE), 2)) |>
  ggplot(aes(year, avg_rating)) +
  geom_line(color = "#4B0082", linewidth = 1) +
  geom_point(color = "#9370DB", size = 3) +
  geom_hline(
    yintercept = round(mean(billboard$overall_rating, na.rm = TRUE), 2),
    color = "#FF6B6B",
    linetype = "dashed",
    linewidth = 1
  ) +
  scale_x_continuous(
    expand = expansion(mult = c(0.02, 0.02)),
    limits = c(1958, 2025),
    breaks = seq(1960, 2025, 5)
  ) +
  scale_y_continuous(
    expand = expansion(mult = c(0.05, 0.05)),
    limits = c(1, 10),
    breaks = seq(1, 10, 1)
  ) +
  custom_theme() +
  labs(
    title = "Evolution of the Average Rating of Billboard Hits",
    subtitle = "By year, based on rankings from 1958 to 2025",
    x = "Year",
    y = "Average Rating (1 to 10)",
    caption = "Red line: global average (all years combined)"
  )

sauvegarder_graphique_ggplot(
  graph_rating_line,
  "2025-08-26",
  "graph_rating_line.png",
  10,
  10,
  400
)

## Évolution des notes maximales et minimales des hits Billboard
billboard_summary <- billboard %>%
  group_by(year) %>%
  summarise(
    max_rating = max(overall_rating, na.rm = TRUE),
    min_rating = min(overall_rating, na.rm = TRUE)
  )

mean_max_rating <- mean(billboard_summary$max_rating, na.rm = TRUE)
mean_min_rating <- mean(billboard_summary$min_rating, na.rm = TRUE)

graph_max_min_rating <- billboard_summary |>
  ggplot() +
  geom_line(aes(year, max_rating), color = "#4B0082", linewidth = 1) +
  geom_point(aes(year, max_rating), color = "#4B0082", size = 2) +
  geom_line(aes(year, min_rating), color = "#9370DB", linewidth = 1) +
  geom_point(aes(year, min_rating), color = "#9370DB", size = 2) +
  geom_hline(
    yintercept = mean_max_rating,
    color = "#FF6B6B",
    linetype = "dashed",
    linewidth = 1
  ) +
  geom_hline(
    yintercept = mean_min_rating,
    color = "#FF6B6B",
    linetype = "dashed",
    linewidth = 1
  ) +
  scale_x_continuous(
    expand = expansion(mult = c(0.02, 0.02)),
    limits = c(1958, 2025),
    breaks = seq(1960, 2025, 5)
  ) +
  scale_y_continuous(
    expand = expansion(mult = c(0.05, 0.05)),
    limits = c(1, 10),
    breaks = seq(1, 10, 1)
  ) +
  custom_theme() +
  labs(
    title = "Evolution of Maximum and Minimum Ratings of Billboard Hits (1958–2025)",
    subtitle = paste(
      "Lines: annual trends | Points: exact values | ",
      "Dashed lines: averages (Max =",
      round(mean_max_rating, 2),
      ", Min =",
      round(mean_min_rating, 2),
      ")"
    ),
    x = "Year",
    y = "Rating (1–10)"
  )

sauvegarder_graphique_ggplot(
  graph_max_min_rating,
  "2025-08-26",
  "graph_max_min_rating.png",
  15,
  10,
  400
)


## Graph résumé métriques par décennie
billboard_summary <- billboard |>
  group_by(decade) |>
  summarize(
    Nb_appearance = n(),
    avg_rating = round(mean(overall_rating, na.rm = TRUE), 2),
    avg_bpm = round(mean(bpm, na.rm = TRUE)),
    avg_length = round(mean(length_sec))
  ) |>
  pivot_longer(
    cols = c(Nb_appearance, avg_rating, avg_length, avg_bpm),
    names_to = "metric",
    values_to = "value"
  ) |>
  mutate(
    metric = factor(
      metric,
      levels = c("Nb_appearance", "avg_rating", "avg_length", "avg_bpm"),
      labels = c(
        "Number of appearances",
        "Average rating",
        "Average duration (s)",
        "Average BPM"
      )
    )
  )


graph_summary_decade <- ggplot(billboard_summary) +
  geom_col(
    aes(x = decade, y = value, fill = metric),
    position = "dodge",
    color = "black"
  ) +
  geom_text(
    aes(x = decade, y = value, label = value, group = metric),
    position = position_dodge(width = 0.9),
    vjust = -0.5,
    size = 4
  ) +
  scale_fill_manual(
    name = "Type of metric",
    values = c(
      "Number of appearances" = "#FFA500",
      "Average rating" = "#9370DB",
      "Average duration (s)" = "#31a354",
      "Average BPM" = "#7092dbff"
    ),
    labels = c(
      "Number of appearances",
      "Average rating",
      "Average duration (s)",
      "Average BPM"
    )
  ) +
  custom_theme() +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  ) +
  labs(
    title = "Billboard Statistics by Decade",
    subtitle = "Note: the y-axis units differ depending on the metric shown.",
    x = "Decade",
    y = "Value",
    fill = "Type of metric"
  )

sauvegarder_graphique_ggplot(
  graph_summary_decade,
  "2025-08-26",
  "graph_summary_decade.png",
  15,
  10,
  400
)


### Top 10 chansons non consécutif
billboard_filtered <- billboard |>
  filter(non_consecutive == 1) |>
  slice_max(order_by = weeks_at_number_one, n = 10) |>
  mutate(song = fct_reorder(song, weeks_at_number_one, .desc = TRUE))

avg_rating = round(mean(billboard_filtered$weeks_at_number_one, na.rm = TRUE))
upper <- max(billboard_filtered$weeks_at_number_one) + 1

graph_top_10_non_consecutive <- billboard_filtered |>
  ggplot(aes(song, weeks_at_number_one)) +
  geom_col(fill = "#028529ff", color = "black") +
  geom_text(aes(label = weeks_at_number_one), vjust = -0.5) +
  geom_hline(
    yintercept = avg_rating,
    color = "#FF6B6B",
    linetype = "dashed",
    linewidth = 1
  ) +
  scale_y_continuous(
    expand = expansion(mult = c(0.05, 0.05)),
    limits = c(0, upper),
    breaks = seq(0, upper, 1)
  ) +
  labs(
    title = "Top Non-Consecutive Songs at the Top of the Billboard Charts",
    subtitle = paste(
      "Ranking based on the number of weeks at number one (including ties) | Red line: global average ",
      round(avg_rating),
      sep = ""
    ),
    x = "Song",
    y = "Number of weeks at number one"
  ) +
  custom_theme() +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)
  )

sauvegarder_graphique_ggplot(
  graph_top_10_non_consécutif,
  "2025-08-26",
  "graph_top_10_non_consécutif.png",
  15,
  10,
  400
)


### Top 10 chansons consécutives
billboard_filtered <- billboard |>
  filter(non_consecutive == 0) |>
  slice_max(order_by = weeks_at_number_one, n = 10) |>
  mutate(song = fct_reorder(song, weeks_at_number_one, .desc = TRUE))

avg_rating <- round(mean(billboard_filtered$weeks_at_number_one, na.rm = TRUE))
upper <- max(billboard_filtered$weeks_at_number_one) + 1

graph_top_10_consecutive <- billboard_filtered |>
  ggplot(aes(song, weeks_at_number_one)) +
  geom_col(fill = "#028529ff", color = "black") +
  geom_text(aes(label = weeks_at_number_one), vjust = -0.5) +
  geom_hline(
    yintercept = avg_rating,
    color = "#FF6B6B",
    linetype = "dashed",
    linewidth = 1
  ) +
  scale_y_continuous(
    expand = expansion(mult = c(0.05, 0.05)),
    limits = c(0, upper),
    breaks = seq(0, upper, 1)
  ) +
  labs(
    title = "Top Consecutive Songs at the Top of the Billboard Charts",
    subtitle = paste(
      "Ranking based on the number of weeks at number one (including ties) | Red line: global average ",
      round(avg_rating),
      sep = ""
    ),
    x = "Song",
    y = "Number of weeks at number one"
  ) +
  custom_theme() +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)
  )


sauvegarder_graphique_ggplot(
  graph_top_10_consécutif,
  "2025-08-26",
  "graph_top_10_consécutif.png",
  15,
  10,
  400
)
