# Import & co ---------------------------------------------

## Load global settings ----
source("~/R things/Tidytuesday/global_settings.R")

## Load additional required libraries ----
library(dplyr)
library(tidyverse)
library(tidytuesdayR)
library(grid)
library(ggtext)
library(ggbump)
library(ggflags)

extrafont::loadfonts(device = c("all"), quiet = TRUE)

## Load data ----
tuesdata <- tidytuesdayR::tt_load(2020, week = 32)

energy_types <- tuesdata$energy_types
country_total <- tuesdata$country_totals

rm(tuesdata)


# Data wrangling ----
eu_codes <- c(
    "AT",
    "BE",
    "BG",
    "CY",
    "CZ",
    "DK",
    "EE",
    "ES",
    "FI",
    "FR",
    "DE",
    "GR",
    "HR",
    "HU",
    "IE",
    "IT",
    "LV",
    "LT",
    "LU",
    "MT",
    "NL",
    "PL",
    "PT",
    "RO",
    "SK",
    "SI",
    "SE"
)

col_palette <- c(
    "Conventional thermal" = "#909090",
    "Nuclear" = "#A89BE8",
    "Hydro" = "#4EB7F5",
    "Wind" = "#74D47B",
    "Solar" = "#FFE24D",
    "Geothermal" = "#FF8C70"
)


energy_types <- energy_types |>
    rename(y_2016 = "2016", y_2017 = "2017", y_2018 = "2018") |>
    mutate(
        country = ifelse(country == "EL", "GR", country),
        green = case_when(
            type == "Conventional thermal" ~ "No",
            TRUE ~ "Yes"
        ),
        UE = country %in% eu_codes
    )
energy_types$color <- col_palette[energy_types$type]

country_total <- country_total |>
    rename(y_2016 = "2016", y_2017 = "2017", y_2018 = "2018") |>
    mutate(
        country = ifelse(country == "EL", "GR", country),
        UE = country %in% eu_codes
    )

# EDA ----
## Energy source composition by country ----
energy_comp <- energy_types |>
    filter(
        UE == TRUE &
            level == "Level 1" &
            type != "Other"
    ) |>
    group_by(country) |>
    mutate(
        total_prod_2016 = sum(y_2016),
        total_prod_2017 = sum(y_2017),
        total_prod_2018 = sum(y_2018)
    ) |>
    ungroup() |>
    mutate(
        pct_2016 = round(y_2016 / total_prod_2016, 2),
        pct_2017 = round(y_2017 / total_prod_2017, 2),
        pct_2018 = round(y_2018 / total_prod_2018, 2),
        pct_2016 = if_else(green == "No", -pct_2016, pct_2016),
        pct_2017 = if_else(green == "No", -pct_2017, pct_2017),
        pct_2018 = if_else(green == "No", -pct_2018, pct_2018)
    )


fr_annotation <- paste0(
    "<b>France</b> is the EU’s nuclear powerhouse, <br>with about <b>71%</b> of its total production coming from nuclear energy."
)
mt_annotation <- paste0(
    "<b>Malta</b> produces all of its energy from <br><b>conventional thermal</b> sources."
)

plt <- energy_comp |>
    ggplot() +
    geom_col(
        aes(reorder(country, desc(pct_2018)), pct_2018, fill = type),
        width = 0.7,
        color = "#f5f5f5",
        linewidth = 0.15
    ) +
    annotate(
        "text",
        x = 13.5,
        y = 0.98,
        label = "Green energy",
        hjust = 0.5,
        family = "Verdana",
        fontface = "bold"
    ) +
    annotate(
        "text",
        x = 13.5,
        y = -0.98,
        label = "Non-green energy",
        hjust = 0.5,
        family = "Verdana",
        fontface = "bold"
    ) +
    annotate(
        geom = "richtext",
        x = 4,
        y = 0.95,
        label = fr_annotation,
        family = "Verdana",
        size = 5,
        color = "grey10",
        hjust = 0,
        vjust = 1,
        fill = "#f5f5f5",
        label.color = NA
    ) +
    annotate(
        geom = "curve",
        x = 4,
        xend = 2.5,
        y = 0.90,
        yend = 0.87,
        curvature = .35,
        angle = 60,
        color = "grey10",
        linewidth = .4,
        arrow = arrow(type = "closed", length = unit(.08, "inches"))
    ) +
    annotate(
        geom = "richtext",
        x = 18,
        y = -0.90,
        label = mt_annotation,
        family = "Verdana",
        size = 5,
        color = "grey10",
        hjust = 0,
        vjust = 1,
        fill = "#f5f5f5",
        label.color = NA
    ) +
    annotate(
        geom = "curve",
        x = 23,
        xend = 26.5,
        y = -0.95,
        yend = -0.97,
        curvature = .35,
        angle = 30,
        color = "grey10",
        linewidth = .4,
        arrow = arrow(type = "closed", length = unit(.08, "inches"))
    ) +
    scale_y_continuous(
        breaks = seq(-1, 1, 0.25),
        labels = scales::percent,
        expand = expansion(add = c(0.05, 0.05))
    ) +
    scale_fill_manual(values = col_palette) +
    labs(
        title = "How green is the EU’s energy? A 2018 snapshot of member states’ energy mix",
        subtitle = "Share of ***green*** (above zero) and ***non-green*** (below zero) energy sources in total production",
        caption = "Graphic: Fabien Haury | Source: #Tidytuesday 2020-08-04",
        x = "Country",
        y = "Share of total energy production (%)",
        fill = "Energy source"
    ) +
    theme(
        plot.background = element_rect(fill = "#f5f5f5", colour = NA),
        plot.title = element_markdown(
            colour = "grey20",
            family = "Verdana",
            face = "bold",
            size = 22
        ),
        plot.subtitle = element_markdown(
            colour = "grey10",
            family = "Verdana",
            face = "italic",
            size = 18
        ),
        plot.caption = element_markdown(
            colour = "grey10",
            family = "Verdana",
            face = "italic",
            size = 12
        ),
        plot.margin = margin(0.01, 0.01, 0.01, 0.01, "npc"),
        panel.background = element_rect(fill = "#f5f5f5", colour = NA),
        panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_line(
            linetype = "dotted",
            colour = "grey80"
        ),
        panel.grid.minor.y = element_blank(),
        axis.text = element_text(
            colour = "grey20",
            family = "Verdana",
            size = 10
        ),
        axis.title = element_text(
            colour = "grey10",
            family = "Verdana",
            size = 20
        ),
        axis.ticks = element_blank(),
        legend.background = element_rect(fill = "#f5f5f5"),
        legend.key = element_rect(fill = "#f5f5f5", colour = "NA"),
        legend.text = element_text(
            colour = "grey20",
            family = "Verdana",
            size = 10
        ),
        legend.title = element_blank(),
        legend.position = "top",
        legend.margin = margin(1, 0, 1, 0),
        legend.box.spacing = unit(0.5, "lines")
    ) +
    guides(fill = guide_legend(nrow = 1))

sauvegarder_graphique_ggplot(
    plt,
    "2020-08-04",
    nom_fichier = "graph_energy_comp_country.png",
    20,
    16,
    forcer = TRUE
)

## Green energy producer ranking ----
energy_rank <- energy_types |>
    filter(
        UE == TRUE &
            level == "Level 1" &
            type != "Other" &
            green != "No"
    ) |>
    group_by(country) |>
    summarise(
        total_prod_2016 = sum(y_2016, na.rm = TRUE),
        total_prod_2017 = sum(y_2017, na.rm = TRUE),
        total_prod_2018 = sum(y_2018, na.rm = TRUE),
        .groups = "drop"
    ) |>
    mutate(
        rank_2016 = rank(-total_prod_2016, ties.method = "first"),
        rank_2017 = rank(-total_prod_2017, ties.method = "first"),
        rank_2018 = rank(-total_prod_2018, ties.method = "first"),
        ranking_change = rank_2016 - rank_2018,
        ranking_change_clean = case_when(
            ranking_change > 0 ~ paste0("+", ranking_change),
            TRUE ~ as.character(ranking_change)
        )
    ) |>
    arrange(rank_2016)

rank_min <- min(energy_rank$rank_2016)
rank_max <- max(energy_rank$rank_2016)

energy_rank_long <- energy_rank |>
    pivot_longer(
        cols = starts_with("total_prod_") | starts_with("rank_"),
        names_to = c(".value", "year"),
        names_pattern = "(total_prod_|rank_)(\\d{4})"
    ) |>
    mutate(year = as.integer(year), country = tolower(country)) |>
    arrange(country, year)


plt <- energy_rank_long |>
    ggplot(aes(year, rank_, country = country)) +
    geom_bump(smooth = 20, linewidth = 1, lineend = "round") +
    geom_point(size = 11, color = "#f5f5f5") +
    geom_point(size = 9, color = "black") +
    geom_flag(size = 8) +
    geom_text(
        data = energy_rank,
        aes(
            x = 2018,
            y = rank_2018,
            label = ranking_change_clean,
            color = case_when(
                ranking_change < 0 ~ "pire",
                ranking_change > 0 ~ "mieux",
                TRUE ~ "stable"
            )
        ),
        nudge_x = 0.08,
        hjust = 1,
        size = 6,
        show.legend = FALSE,
        family = "Verdana",
        fontface = "bold"
    ) +
    scale_x_continuous(
        breaks = seq(2016, 2018, 1),
        expand = expansion(mult = c(0.02, 0.02))
    ) +
    scale_y_reverse(
        limits = c(rank_min, rank_max),
        breaks = c(rank_min, 5, 10, 15, 20, 25, rank_max),
        expand = expansion(add = c(0.5, 0.5))
    ) +
    scale_color_manual(
        values = c(
            "mieux" = "forestgreen",
            "pire" = "firebrick",
            "stable" = "grey40"
        )
    ) +
    labs(
        title = "EU Green Energy Production Rankings (2016-2018)",
        subtitle = "Ranking of EU countries by total green energy production",
        caption = "Graphic: Fabien Haury | Source: #Tidytuesday 2020-08-04",
        x = NULL,
        y = "Rank"
    ) +
    theme(
        plot.background = element_rect(fill = "#f5f5f5", colour = NA),
        plot.title = element_markdown(
            colour = "grey20",
            family = "Verdana",
            face = "bold",
            size = 22,
            hjust = 0,
            margin = margin(0.01, 0.01, 0.01, 0.01, "npc")
        ),
        plot.subtitle = element_markdown(
            colour = "grey10",
            family = "Verdana",
            face = "italic",
            size = 18,
            hjust = 0,
            margin = margin(0.01, 0.01, 0.02, 0.01, "npc")
        ),
        plot.caption = element_markdown(
            colour = "grey10",
            family = "Verdana",
            face = "italic",
            size = 12,
            hjust = 0,
            margin = margin(0.02, 0.01, 0.01, 0.01, "npc")
        ),
        plot.margin = margin(0.01, 0.01, 0.01, 0.01, "npc"),
        panel.background = element_rect(fill = "#f5f5f5", colour = NA),
        axis.ticks = element_blank(),
        axis.text.y = element_text(
            margin = margin(0, 0, 0, 1),
            colour = "grey10",
            family = "Verdana",
            face = "bold"
        ),
        axis.title.y.left = element_text(
            margin = margin(0, 1, 0, 0),
            colour = "grey10",
            family = "Verdana"
        ),
        panel.grid = element_blank(),
    )

ragg::agg_png(
    "C:/Users/fabie/Documents/R things/Tidytuesday/Date/2020-08-04/Graphique_tableau/graph_ranking_country.png",
    width = 16,
    height = 12,
    units = "in",
    res = 400
)

print(plt)

grid.rect(
    x = 0.79,
    y = 0.930,
    width = 0.18,
    height = 0.05,
    just = c("left", "bottom"),
    gp = gpar(fill = NA, col = "grey80")
)

grid.text(
    paste0("Most postive change: +", max(energy_rank$ranking_change)),
    x = 0.80,
    y = 0.960,
    just = c("left", "bottom"),
    gp = gpar(
        fontfamily = "Verdana",
        fontface = "bold",
        fontsize = 12
    )
)

grid.text(
    paste0("Most negative change: ", min(energy_rank$ranking_change)),
    x = 0.80,
    y = 0.940,
    just = c("left", "bottom"),
    gp = gpar(
        fontfamily = "Verdana",
        fontface = "bold",
        fontsize = 12
    )
)

dev.off()
