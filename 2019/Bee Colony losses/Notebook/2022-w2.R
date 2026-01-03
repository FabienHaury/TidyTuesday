# creer_dossiers_date_et_graphique("2022-01-11") ----
# Import & co ----

## Load global settings ----
source("~/R things/Tidytuesday/global_settings.R")

## Load additional required libraries ----
library(dplyr)
library(tidyverse)
library(tidytuesdayR)
library(patchwork)
library(ggrepel)

extrafont::loadfonts(device = c("all"), quiet = TRUE)

## Load data ----
tuesdata <- tidytuesdayR::tt_load(2022, week = 2)

colony <- tuesdata$colony
stressor <- tuesdata$stressor

rm(tuesdata)


# Data wrangling ----
stressor <- stressor |>
    mutate(
        quarter = case_when(
            months == "January-March" ~ "Q1",
            months == "April-June" ~ "Q2",
            months == "July-September" ~ "Q3",
            TRUE ~ "Q4"
        )
    )
# EDA ----
## --- Data preparation ----
stressor_us <- stressor |>
    filter(state == "United States") |>
    mutate(
        year_quart = factor(
            str_c(year, quarter, sep = "-"),
            levels = unique(str_c(year, quarter, sep = "-"))
        ),
        stress_pct = stress_pct / 100
    ) |>
    select(stressor, stress_pct, year_quart, year, quarter)


## --- X-axis label creation ----
labs_df <- stressor_us |>
    distinct(year_quart, .keep_all = TRUE) |>
    arrange(year_quart)

x_breaks <- labs_df$year_quart
x_labels <- paste0(
    labs_df$quarter,
    "\n",
    ifelse(labs_df$quarter == "Q1", labs_df$year, "")
)


## --- Color palette ----
my_palette <- c(
    "#000000",
    "#8C001A",
    "#C62828",
    "#00695C",
    "#4A00C8"
)


## --- Data for final labels ----
stressor_end_varroa <- stressor_us |>
    filter(stressor == "Varroa mites") |>
    group_by(stressor) |>
    slice_tail(n = 1) |>
    ungroup()

stressor_end_no_varroa <- stressor_us |>
    filter(stressor != "Varroa mites") |>
    group_by(stressor) |>
    slice_tail(n = 1) |>
    ungroup()


## --- Plot 1: Varroa mites ----
p1 <- stressor_us |>
    filter(stressor == "Varroa mites") |>
    ggplot() +
    annotate(
        "rect",
        xmin = "2019-Q1",
        xmax = "2019-Q3",
        ymin = 0,
        ymax = 0.60,
        alpha = 0.3,
        fill = "gray"
    ) +
    annotate(
        "text",
        x = "2019-Q2",
        y = 0.57,
        label = "Missing data",
        vjust = -1,
        size = 5,
        color = "gray30",
        family = "Calibri",
        fontface = "bold"
    ) +
    geom_line(
        aes(year_quart, stress_pct, group = stressor, colour = stressor),
        linejoin = "bevel",
        lineend = "round",
        linewidth = 1.2
    ) +
    geom_text_repel(
        data = stressor_end_varroa,
        aes(label = stressor, x = "2021-Q2", y = stress_pct),
        hjust = 0,
        nudge_x = 0.5,
        family = "Lato",
        fontface = "bold",
        size = 4.5,
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
    scale_x_discrete(
        breaks = x_breaks,
        labels = x_labels,
        expand = expansion(mult = c(0, 0.1))
    ) +
    scale_y_continuous(
        labels = scales::percent_format(),
        n.breaks = 6,
        expand = expansion(mult = c(0.01, 0.01))
    ) +
    scale_color_manual(values = "#14532D") +
    labs(x = NULL, y = NULL) +
    theme(
        plot.background = element_rect(fill = "#F5F5DC", color = NA),
        panel.background = element_rect(fill = "#F5F5DC", color = NA),
        panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_line(
            color = "#0D4A6B",
            linetype = "dashed",
            linewidth = 0.25
        ),
        panel.grid.minor.y = element_line(
            color = "#0D4A6B",
            linetype = "dotted",
            linewidth = 0.1
        ),
        axis.text.x = element_text(
            family = "Calibri",
            size = 11,
            vjust = 0.5,
            hjust = 0.5
        ),
        axis.text.y = element_text(family = "Calibri", size = 11),
        axis.ticks.y = element_blank(),
        panel.border = element_rect(color = "black", linewidth = 0.25)
    ) +
    guides(color = "none")


## --- Plot 2: Other stressors ----
p2 <- stressor_us |>
    filter(stressor != "Varroa mites") |>
    ggplot() +
    annotate(
        "rect",
        xmin = "2019-Q1",
        xmax = "2019-Q3",
        ymin = 0,
        ymax = 0.25,
        alpha = 0.3,
        fill = "gray"
    ) +
    annotate(
        "text",
        x = "2019-Q2",
        y = 0.23,
        label = "Missing data",
        vjust = -1,
        size = 5,
        color = "gray30",
        family = "Calibri",
        fontface = "bold"
    ) +
    geom_line(
        aes(year_quart, stress_pct, group = stressor, colour = stressor),
        linejoin = "bevel",
        lineend = "round",
        linewidth = 1.2
    ) +
    geom_text_repel(
        data = stressor_end_no_varroa,
        aes(label = stressor, x = "2021-Q2", y = stress_pct),
        hjust = 0,
        nudge_x = 0.5,
        family = "Lato",
        fontface = "bold",
        size = 4.5,
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
    scale_x_discrete(
        breaks = x_breaks,
        labels = x_labels,
        expand = expansion(mult = c(0, 0.1))
    ) +
    scale_y_continuous(
        labels = scales::percent_format(),
        expand = expansion(mult = c(0.01, 0.01))
    ) +
    scale_color_manual(values = my_palette) +
    labs(x = NULL, y = NULL) +
    theme(
        plot.background = element_rect(fill = "#F5F5DC", color = NA),
        panel.background = element_rect(fill = "#F5F5DC", color = NA),
        panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_line(
            color = "#0D4A6B",
            linetype = "dashed",
            linewidth = 0.25
        ),
        panel.grid.minor.y = element_line(
            color = "#0D4A6B",
            linetype = "dotted",
            linewidth = 0.1
        ),
        axis.text.x = element_text(
            family = "Calibri",
            size = 11,
            vjust = 0.5,
            hjust = 0.5
        ),
        axis.text.y = element_text(family = "Calibri", size = 11),
        axis.ticks.y = element_blank(),
        panel.border = element_rect(color = "black", linewidth = 0.25)
    ) +
    guides(color = "none")


## --- Final composition ----
plt <- (p1 / p2) +
    plot_annotation(
        title = " Trends in Primary Stressors Affecting U.S. Honey Bee Colonies (2015–2021)",
        subtitle = " Varroa mites remain the leading cause of colony stress, while other factors show smaller but persistent impacts.",
        caption = "Created by: Fabien Haury | Data source: #Tidytuesday 2022-01-11",
        theme = theme(
            plot.title = element_text(
                hjust = 0,
                family = "Calibri",
                face = "bold",
                size = 24,
                color = "#1A1A1A"
            ),
            plot.subtitle = element_text(
                hjust = 0,
                family = "Calibri",
                face = "italic",
                size = 18,
                color = "#1A1A1A"
            ),
            plot.caption = element_text(
                hjust = 0,
                family = "Calibri",
                size = 11,
                color = "#4A6D8A"
            ),
            plot.background = element_rect(fill = "#F5F5DC", color = NA),
            panel.background = element_rect(fill = "#F5F5DC", color = NA)
        )
    )


sauvegarder_graphique_ggplot(
    plt,
    "2022-01-11",
    "graph_test.png",
    20,
    15,
    forcer = TRUE
)
