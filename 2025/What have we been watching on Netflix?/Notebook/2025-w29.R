# Load global settings
source("~/R things/Tidytuesday/global_settings.R")

# Load additional required libraries
library(dplyr)
library(tidyverse)
library(tidytuesdayR)
library(lubridate)
library(summarytools)
library(scales)
library(gt)

# Load data
tuesdata <- tidytuesdayR::tt_load(2025, week = 30)

# Get data
movies <- tuesdata$movies
shows <- tuesdata$shows

# Remove tuesdata
rm(tuesdata)


#################################################################### Data wrangling #########################################################
# Quick overview
dfSummary(movies)
dfSummary(shows)

# Quick resume :
# 1. First column is useless.
# 2. Strange data in column available_globally that need to be removed.
# 3. Column release_date is full of missing data (up to 81% for movies DF) so useless. But keeping it for now.
# 4. Column runtime is a string, so changing it to DateTime is required to be able to do things with it. And creating runtime category.
# 5. Some title in movies are clearly series ans not movies, so I will delete them.

# 1. Removing first column.
movies <- movies |>
  select(-c('source'))
shows <- shows |>
  select(-c('source'))

# 2. Removing rows containing Available Globally? in the column with the same name
movies <- movies |>
  filter(available_globally != 'Available Globally?')
shows <- shows |>
  filter(available_globally != 'Available Globally?')

# 4. Converting runtime into something usable.
## Movies df
movies$runtime_iso <- gsub(" ", "", paste0("PT", movies$runtime))
movies$runtime_dur <- as.duration(movies$runtime_iso)
movies$runtime_minutes <- round(
  as.numeric(movies$runtime_dur, "minutes"),
  digits = 0
)

movies <- movies |>
  select(-c(runtime, runtime_iso, runtime_dur))

movies$runtime_category <- dplyr::case_when(
  movies$runtime_minutes < 40 ~ "short",
  movies$runtime_minutes < 75 ~ "short feature",
  movies$runtime_minutes <= 120 ~ "normal",
  movies$runtime_minutes <= 150 ~ "long",
  movies$runtime_minutes <= 180 ~ "very long",
  TRUE ~ "outlier"
)

movies <- movies %>%
  mutate(
    runtime_category = factor(
      runtime_category,
      levels = c(
        "short",
        "short feature",
        "normal",
        "long",
        "very long",
        "outlier"
      ),
      labels = c(
        "Short",
        "Short feature",
        "Normal",
        "Long",
        "Very long",
        "Outlier"
      )
    )
  )


## Shows df
shows$runtime_iso <- gsub(" ", "", paste0("PT", shows$runtime))
shows$runtime_dur <- as.duration(shows$runtime_iso)
shows$runtime_minutes <- round(
  as.numeric(shows$runtime_dur, "minutes"),
  digits = 0
)

shows <- shows |>
  select(-c(runtime, runtime_iso, runtime_dur))

shows$runtime_category <- dplyr::case_when(
  shows$runtime_minutes >= 2 & shows$runtime_minutes <= 30 ~ "Ultra-Short",
  shows$runtime_minutes >= 31 & shows$runtime_minutes <= 120 ~ "Very short",
  shows$runtime_minutes >= 121 & shows$runtime_minutes <= 300 ~ "Short",
  shows$runtime_minutes >= 301 & shows$runtime_minutes <= 720 ~ "Standard",
  shows$runtime_minutes >= 721 & shows$runtime_minutes <= 1440 ~ "Long",
  shows$runtime_minutes >= 1441 & shows$runtime_minutes <= 3600 ~ "Very Long",
  shows$runtime_minutes >= 3601 & shows$runtime_minutes <= 7200 ~ "Epic",
  shows$runtime_minutes >= 7201 & shows$runtime_minutes <= 14400 ~ "Marathon",
  shows$runtime_minutes >= 14401 & shows$runtime_minutes <= 23853 ~
    "Megaseries",
  TRUE ~ NA_character_
)

shows <- shows %>%
  mutate(
    runtime_category = factor(
      runtime_category,
      levels = c(
        "Ultra-Short",
        "Very short",
        "Short",
        "Long",
        "Standard",
        "Very Long",
        "Epic",
        "Marathon",
        "Megaseries"
      ),
      labels = c(
        "Ultra-Short",
        "Very short",
        "Short",
        "Long",
        "Standard",
        "Very Long",
        "Epic",
        "Marathon",
        "Megaseries"
      )
    )
  )


# 5. Deleting wrong movies/shows in each df if necessary.
## Movies df
series_keywords <- c("Season", "Series", "Limited Series")
movies <- movies %>%
  filter(!str_detect(title, paste(series_keywords, collapse = "|")))


#################################################################### EDA #########################################################
# Movies
movies_avg <- movies |>
  group_by(report) |>
  summarise(
    avg_hours = mean(hours_viewed, na.rm = TRUE),
    avg_views = mean(views, na.rm = TRUE),
    avg_runtime = mean(runtime_minutes, na.rm = TRUE)
  )

## Graphics
### Facet wrap by report for hours viewed
movies_prep <- movies |>
  group_by(report, runtime_category) |>
  summarise(avg = mean(hours_viewed)) |>
  mutate(
    label_text = label_number(scale = 1e-6, suffix = "M", accuracy = 0.1)(avg)
  )

facet_labels <- paste(
  "Period: ",
  movies_avg$report,
  "\nRed line: Average viewing: ",
  label_number(scale = 1e-6, suffix = "M", accuracy = 0.1)(
    movies_avg$avg_hours
  ),
  sep = ""
)
names(facet_labels) <- movies_avg$report


graph_movies_hours <- movies_prep |>
  ggplot(aes(runtime_category, avg)) +
  geom_col(fill = "#F59E52", color = "black") +
  geom_text(aes(label = label_text), vjust = -0.5) +
  geom_hline(
    data = movies_avg,
    aes(yintercept = avg_hours),
    color = "#FF6B6B",
    linetype = "dashed",
    linewidth = 1
  ) +
  scale_y_continuous(
    expand = c(0, 0),
    limits = c(0, 7000000),
    breaks = seq(0, 7000000, 1000000),
    labels = function(x) {
      label_number(scale = 1e-6, suffix = "M", accuracy = 0.1)(x)
    }
  ) +
  facet_wrap(~report, labeller = as_labeller(facet_labels)) +
  custom_theme() +
  labs(
    x = "Runtime Category",
    y = "Average Hours Viewed",
    title = "Movie Viewing by Runtime Category"
  ) +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    strip.text = element_text(face = "bold", size = 10)
  )

sauvegarder_graphique_ggplot(
  graph_movies_hours,
  "2025-07-29",
  "graph_movies_hours.png",
  width = 20,
  height = 20,
  dpi = 400
)


### Facet wrap by report for views
movies_prep <- movies |>
  group_by(report, runtime_category) |>
  summarise(avg = mean(views)) |>
  mutate(
    label_text = label_number(scale = 1e-6, suffix = "M", accuracy = 0.1)(avg)
  )

facet_labels <- paste(
  "Period: ",
  movies_avg$report,
  "\nRed line: Average views: ",
  label_number(scale = 1e-6, suffix = "M", accuracy = 0.1)(
    movies_avg$avg_views
  ),
  sep = ""
)
names(facet_labels) <- movies_avg$report


graph_movies_views <- movies_prep |>
  ggplot(aes(runtime_category, avg)) +
  geom_col(fill = "#EAC43B", color = "black") +
  geom_text(aes(label = label_text), vjust = -0.5) +
  geom_hline(
    data = movies_avg,
    aes(yintercept = avg_views),
    color = "#FF6B6B",
    linetype = "dashed",
    linewidth = 1
  ) +
  scale_y_continuous(
    expand = c(0, 0),
    limits = c(0, 3500000),
    breaks = seq(0, 3500000, 500000),
    labels = function(x) {
      label_number(scale = 1e-6, suffix = "M", accuracy = 0.1)(x)
    }
  ) +
  facet_wrap(~report, labeller = as_labeller(facet_labels)) +
  custom_theme() +
  labs(
    x = "Runtime Category",
    y = "Average Views",
    title = "Movie Views by Runtime Category"
  ) +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    strip.text = element_text(face = "bold", size = 10)
  )

sauvegarder_graphique_ggplot(
  graph_movies_views,
  "2025-07-29",
  "graph_movies_views.png",
  width = 20,
  height = 20,
  dpi = 400
)


## Table
### Table report/available/category
tab_movies_report_avail_cat <- movies |>
  group_by(report, available_globally, runtime_category) |>
  summarise(
    total = n(),
    max_hours_viewed = max(hours_viewed, na.rm = TRUE),
    min_hours_viewed = min(hours_viewed, na.rm = TRUE),
    avg_hours_viewed = mean(hours_viewed, na.rm = TRUE),
    max_views = max(views, na.rm = TRUE),
    min_views = min(views, na.rm = TRUE),
    avg_views = mean(views, na.rm = TRUE),
    max_runtime = hms::hms(seconds = max(runtime_minutes, na.rm = TRUE) * 60),
    min_runtime = hms::hms(seconds = min(runtime_minutes, na.rm = TRUE) * 60),
    avg_runtime = hms::hms(
      seconds = round(mean(runtime_minutes, na.rm = TRUE), 0) * 60
    ),
    .groups = "drop"
  ) |>
  mutate(
    report_available_globally = paste0(report, "-", available_globally),
    .keep = "unused",
    .before = 1
  ) |>
  gt(
    rowname_col = "runtime_category",
    groupname_col = "report_available_globally",
    row_group_as_column = TRUE
  ) |>
  fmt_number(
    suffixing = TRUE,
    n_sigfig = 2,
    columns = c(
      "total",
      "max_hours_viewed",
      "min_hours_viewed",
      "avg_hours_viewed",
      "max_views",
      "min_views",
      "avg_views",
      "max_runtime",
      "min_runtime",
      "avg_runtime"
    )
  ) |>
  fmt_time(
    columns = c('max_runtime', 'min_runtime', 'avg_runtime'),
    time_style = "iso-short"
  ) |>
  tab_header(
    title = md(
      "**Which shows formats are the most captivating? An analysis by duration**"
    ),
    subtitle = md(
      "*Comparison of hours watched, views, and durations, based on global availability and film length*"
    )
  ) |>
  tab_stubhead(label = "Period-Available-globally? | Duration") |>
  cols_label(
    total = md("**Total**"),
    max_hours_viewed = md("**Max Hours**"),
    min_hours_viewed = md("**Min Hours**"),
    avg_hours_viewed = md("**Avg Hours**"),
    max_views = md("**Max Views**"),
    min_views = md("**Min Views**"),
    avg_views = md("**Avg Views**"),
    max_runtime = md("**Max Length**"),
    min_runtime = md("**Min Length**"),
    avg_runtime = md("**Avg Length**")
  ) |>
  cols_align(
    align = "center",
    columns = c(
      "total",
      "max_hours_viewed",
      "min_hours_viewed",
      "avg_hours_viewed",
      "max_views",
      "min_views",
      "avg_views",
      "max_runtime",
      "min_runtime",
      "avg_runtime"
    )
  ) |>
  cols_width(
    total ~ px(75),
    max_hours_viewed ~ px(75),
    min_hours_viewed ~ px(75),
    avg_hours_viewed ~ px(75),
    max_views ~ px(75),
    min_views ~ px(75),
    avg_views ~ px(75),
    max_runtime ~ px(75),
    min_runtime ~ px(75),
    avg_runtime ~ px(75)
  ) |>
  tab_options(
    summary_row.background.color = "gray95",
    row_group.as_column = TRUE
  ) |>
  opt_stylize(style = 2, color = "red")


sauvegarder_tableau_gt(
  tab_movies_report_avail_cat,
  "2025-07-29",
  "tab_movies_report_avail_cat.png"
)


### Table for the most viewed movies for each period and available globally.
tab_movies_best_title <- movies |>
  group_by(report, available_globally) |>
  mutate(
    max_views = max(views),
    runtime_minutes = hms::hms(seconds = runtime_minutes * 60)
  ) |>
  filter(views %in% max_views) |>
  select(-c(release_date, max_views)) |>
  gt(
    rowname_col = "available_globally",
    groupname_col = "report",
    row_group_as_column = TRUE
  ) |>
  fmt_number(
    suffixing = TRUE,
    n_sigfig = 2,
    columns = c(
      "hours_viewed",
      "views"
    )
  ) |>
  fmt_time(columns = 'runtime_minutes', time_style = "iso-short") |>
  tab_header(
    title = md(
      "**Analyzing the Most Engaging Movies by Audience Numbers**"
    ),
    subtitle = md(
      "*A comparison of views, total hours watched, and show length based on global availability*"
    )
  ) |>
  tab_stubhead(label = "Period | Available globally?") |>
  cols_label(
    title = md("**Title**"),
    hours_viewed = md("**Hours viewed**"),
    views = md("**Views**"),
    runtime_minutes = md("**Duration**"),
    runtime_category = md("**Duration category**")
  ) |>
  cols_align(
    align = "center",
    columns = c(
      "available_globally",
      "title",
      "hours_viewed",
      "views",
      "runtime_minutes",
      "runtime_category"
    )
  ) |>
  cols_width(
    report ~ px(110),
    available_globally ~ px(75),
    title ~ px(150),
    hours_viewed ~ px(75),
    views ~ px(75),
    runtime_minutes ~ px(75),
    runtime_category ~ px(80)
  ) |>
  opt_stylize(style = 2, color = "red")

sauvegarder_tableau_gt(
  tab_movies_best_title,
  "2025-07-29",
  "tab_movies_best_title.png",
  forcer = TRUE
)


# Shows
## Graphics
shows_avg <- shows |>
  drop_na(runtime_category) |>
  group_by(report) |>
  summarise(
    avg_hours = mean(hours_viewed, na.rm = TRUE),
    avg_views = mean(views, na.rm = TRUE),
    avg_runtime = mean(runtime_minutes, na.rm = TRUE)
  )

### Facet wrap by report for hours viewed
shows_prep <- shows |>
  drop_na(runtime_category) |>
  group_by(report, runtime_category) |>
  summarise(avg = mean(hours_viewed)) |>
  mutate(
    label_text = label_number(scale = 1e-6, suffix = "M", accuracy = 0.1)(avg)
  )

facet_labels <- paste(
  "Period: ",
  shows_avg$report,
  "\nRed line: Average viewing: ",
  label_number(scale = 1e-6, suffix = "M", accuracy = 0.1)(
    shows_avg$avg_hours
  ),
  sep = ""
)
names(facet_labels) <- shows_avg$report


graph_shows_hours <- shows_prep |>
  ggplot(aes(runtime_category, avg)) +
  geom_col(fill = "#F59E52", color = "black") +
  geom_text(aes(label = label_text), vjust = -0.5) +
  geom_hline(
    data = shows_avg,
    aes(yintercept = avg_hours),
    color = "#FF6B6B",
    linetype = "dashed",
    linewidth = 1
  ) +
  scale_y_continuous(
    expand = c(0, 0),
    limits = c(0, 78000000),
    breaks = seq(0, 75000000, 15000000),
    labels = function(x) {
      label_number(scale = 1e-6, suffix = "M", accuracy = 0.1)(x)
    }
  ) +
  facet_wrap(~report, labeller = as_labeller(facet_labels)) +
  custom_theme() +
  labs(
    x = "Runtime Category",
    y = "Average Hours Viewed",
    title = "Series Viewing by Runtime Category"
  ) +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    strip.text = element_text(face = "bold", size = 10)
  )

sauvegarder_graphique_ggplot(
  graph_shows_hours,
  "2025-07-29",
  "graph_shows_hours.png",
  width = 20,
  height = 20,
  dpi = 400
)


### Facet wrap by report for views
shows_prep <- shows |>
  drop_na(runtime_category) |>
  group_by(report, runtime_category) |>
  summarise(avg = mean(views)) |>
  mutate(
    label_text = label_number(scale = 1e-6, suffix = "M", accuracy = 0.1)(avg)
  )

facet_labels <- paste(
  "Period: ",
  shows_avg$report,
  "\nRed line: Average views: ",
  label_number(scale = 1e-6, suffix = "M", accuracy = 0.1)(
    shows_avg$avg_views
  ),
  sep = ""
)
names(facet_labels) <- shows_avg$report


graph_shows_views <- shows_prep |>
  ggplot(aes(runtime_category, avg)) +
  geom_col(fill = "#EAC43B", color = "black") +
  geom_text(aes(label = label_text), vjust = -0.5) +
  geom_hline(
    data = shows_avg,
    aes(yintercept = avg_views),
    color = "#FF6B6B",
    linetype = "dashed",
    linewidth = 1
  ) +
  scale_y_continuous(
    expand = c(0, 0),
    limits = c(0, 3500000),
    breaks = seq(0, 3500000, 500000),
    labels = function(x) {
      label_number(scale = 1e-6, suffix = "M", accuracy = 0.1)(x)
    }
  ) +
  facet_wrap(~report, labeller = as_labeller(facet_labels)) +
  custom_theme() +
  labs(
    x = "Runtime Category",
    y = "Average Views",
    title = "Series Views by Runtime Category"
  ) +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    strip.text = element_text(face = "bold", size = 10)
  )

sauvegarder_graphique_ggplot(
  graph_shows_views,
  "2025-07-29",
  "graph_shows_views.png",
  width = 20,
  height = 20,
  dpi = 400
)


## Table
## Table report/available/category
tab_shows_report_avail_cat <- shows |>
  drop_na(runtime_category) |>
  group_by(report, available_globally, runtime_category) |>
  summarise(
    total = n(),
    max_hours_viewed = max(hours_viewed, na.rm = TRUE),
    min_hours_viewed = min(hours_viewed, na.rm = TRUE),
    avg_hours_viewed = mean(hours_viewed, na.rm = TRUE),
    max_views = max(views, na.rm = TRUE),
    min_views = min(views, na.rm = TRUE),
    avg_views = mean(views, na.rm = TRUE),
    max_runtime = hms::hms(seconds = max(runtime_minutes, na.rm = TRUE) * 60),
    min_runtime = hms::hms(seconds = min(runtime_minutes, na.rm = TRUE) * 60),
    avg_runtime = hms::hms(
      seconds = round(mean(runtime_minutes, na.rm = TRUE), 0) * 60
    ),
    .groups = "drop"
  ) |>
  mutate(
    report_available_globally = paste0(report, "-", available_globally),
    .keep = "unused",
    .before = 1
  ) |>
  gt(
    rowname_col = "runtime_category",
    groupname_col = "report_available_globally",
    row_group_as_column = TRUE
  ) |>
  fmt_number(
    suffixing = TRUE,
    n_sigfig = 2,
    columns = c(
      "total",
      "max_hours_viewed",
      "min_hours_viewed",
      "avg_hours_viewed",
      "max_views",
      "min_views",
      "avg_views",
      "max_runtime",
      "min_runtime",
      "avg_runtime"
    )
  ) |>
  tab_header(
    title = md(
      "**Which shows formats are the most captivating? An analysis by duration**"
    ),
    subtitle = md(
      "*Comparison of hours watched, views, and durations, based on global availability and shows length*"
    )
  ) |>
  tab_stubhead(label = "Period-Available-globally? | Duration") |>
  cols_label(
    total = md("**Total**"),
    max_hours_viewed = md("**Max Hours**"),
    min_hours_viewed = md("**Min Hours**"),
    avg_hours_viewed = md("**Avg Hours**"),
    max_views = md("**Max Views**"),
    min_views = md("**Min Views**"),
    avg_views = md("**Avg Views**"),
    max_runtime = md("**Max Length**"),
    min_runtime = md("**Min Length**"),
    avg_runtime = md("**Avg Length**")
  ) |>
  cols_align(
    align = "center",
    columns = c(
      "total",
      "max_hours_viewed",
      "min_hours_viewed",
      "avg_hours_viewed",
      "max_views",
      "min_views",
      "avg_views",
      "max_runtime",
      "min_runtime",
      "avg_runtime"
    )
  ) |>
  cols_width(
    total ~ px(75),
    max_hours_viewed ~ px(75),
    min_hours_viewed ~ px(75),
    avg_hours_viewed ~ px(75),
    max_views ~ px(75),
    min_views ~ px(75),
    avg_views ~ px(75),
    max_runtime ~ px(75),
    min_runtime ~ px(75),
    avg_runtime ~ px(75)
  ) |>
  tab_options(
    summary_row.background.color = "gray95",
    row_group.as_column = TRUE
  ) |>
  opt_stylize(style = 2, color = "red")

sauvegarder_tableau_gt(
  tab_shows_report_avail_cat,
  "2025-07-29",
  "tab_shows_report_avail_cat.png"
)


### Table for the most viewed movies for each period and available globally.
tab_shows_best_title <- shows |>
  group_by(report, available_globally) |>
  mutate(
    max_views = max(views),
    runtime_minutes = hms::hms(seconds = runtime_minutes * 60)
  ) |>
  filter(views %in% max_views) |>
  select(-c(release_date, max_views)) |>
  gt(
    rowname_col = "available_globally",
    groupname_col = "report",
    row_group_as_column = TRUE
  ) |>
  fmt_number(
    suffixing = TRUE,
    n_sigfig = 2,
    columns = c(
      "hours_viewed",
      "views"
    )
  ) |>
  fmt_time(columns = 'runtime_minutes', time_style = "iso-short") |>
  tab_header(
    title = md(
      "**Analyzing the Most Engaging Series by Audience Numbers**"
    ),
    subtitle = md(
      "*A comparison of views, total hours watched, and show length based on global availability*"
    )
  ) |>
  tab_stubhead(label = "Period | Available globally?") |>
  cols_label(
    title = md("**Title**"),
    hours_viewed = md("**Hours viewed**"),
    views = md("**Views**"),
    runtime_minutes = md("**Duration**"),
    runtime_category = md("**Duration category**")
  ) |>
  cols_align(
    align = "center",
    columns = c(
      "available_globally",
      "title",
      "hours_viewed",
      "views",
      "runtime_minutes",
      "runtime_category"
    )
  ) |>
  cols_width(
    report ~ px(110),
    available_globally ~ px(75),
    title ~ px(150),
    hours_viewed ~ px(75),
    views ~ px(75),
    runtime_minutes ~ px(75),
    runtime_category ~ px(80)
  ) |>
  opt_stylize(style = 2, color = "red")

sauvegarder_tableau_gt(
  tab_shows_best_title,
  "2025-07-29",
  "tab_shows_best_title.png",
  forcer = TRUE
)
