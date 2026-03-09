# THEME SYSTEM ----
## Basic global theme, used everywhere
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

## Variation with cream background
theme_creme <- function() {
  theme_global() +
    theme(
      plot.background = element_rect(fill = "#F1E9D2", color = "#F1E9D2")
    )
}

# DF summary ----
df_summary <- function(df) {
  list(
    summary = df |>
      dplyr::summarise(
        Starting_year = min(year_ended_june, na.rm = TRUE),
        Ending_year = max(year_ended_june, na.rm = TRUE),
        Min_value = min(value, na.rm = TRUE),
        Min_year = year_ended_june[which.min(value)],
        Max_value = max(value, na.rm = TRUE),
        Max_year = year_ended_june[which.max(value)]
      ),
    missing_years = df |>
      dplyr::filter(is.na(value)) |>
      dplyr::pull(year_ended_june)
  )
}
