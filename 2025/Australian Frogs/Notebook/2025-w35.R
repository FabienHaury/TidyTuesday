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
library(ozmaps)
library(sf)
library(viridis)
library(units)
library(concaveman)

# Load data
tuesdata <- tidytuesdayR::tt_load(2025, week = 35)

# Get data id needed
frogs <- tuesdata$frogID_data

# Remove tuesdata
rm(tuesdata)


################################################## Data wrangling #############################################
## Convertir les colonnes en int
frogs <- frogs |>
  mutate_at(c("occurrenceID", "eventID", "recordedBy"), as.integer)


## Création colonnes genus et espèce depuis scientifName
frogs <- frogs |>
  separate(
    scientificName,
    into = c("genus", "specie"),
    sep = " ",
    remove = FALSE
  )


################################################## EDA #################################################
################################################## Tableaux #################################################
# ID recorder
## Top 5 ID recorder/Observers par genus, specie,Region
ID_observers_top_5 <- frogs |>
  count(recordedBy) |>
  slice_max(n, n = 5) |>
  mutate(
    Observers = factor(
      recordedBy,
      levels = recordedBy,
      labels = paste0("Observer ", 1:5)
    )
  ) |>
  ungroup()

tab_ID_observers_top_5 <- frogs |>
  left_join(y = ID_observers_top_5, by = "recordedBy") |>
  filter(recordedBy %in% ID_observers_top_5$recordedBy) |>
  group_by(Observers, genus, specie, stateProvince) |>
  summarise(count = n()) |>
  arrange(Observers, desc(count))

tab_ID_observers_top_5 <- tab_ID_observers_top_5 |>
  gt(groupname_col = "Observers") |>
  tab_header(
    title = "Frog Sightings by Top 5 Observers",
    subtitle = "Summary by Genus, Species and State"
  ) |>
  tab_style(
    style = cell_text(align = "center"),
    locations = cells_row_groups()
  ) |>
  tab_style(
    style = cell_fill(color = "lightblue"),
    locations = cells_row_groups()
  ) |>
  data_color(
    columns = c("count"),
    colors = scales::col_numeric(
      palette = c("#FFFFE0", "#FFA500", "#FF0000"),
      domain = range(tab_ID_observers_top_5$count, na.rm = TRUE)
    )
  ) |>
  cols_label(
    Observers = "Observers",
    genus = "Genus",
    specie = "Species",
    stateProvince = "State",
    count = "Total"
  ) |>
  cols_width(
    Observers ~ px(200),
    genus ~ px(150),
    specie ~ px(150),
    stateProvince ~ px(150),
    count ~ px(75)
  ) |>
  cols_align(
    align = "center",
    columns = c("count")
  )

sauvegarder_tableau_gt(
  tab_ID_observers_top_5,
  "2025-09-02",
  "tab_ID_observers_top_5.png"
)


# Etat
## Classement apparition état
tab_state_ranking <- frogs |>
  count(stateProvince) |>
  arrange(desc(n)) |>
  gt() |>
  tab_header(
    title = "Ranking of Australian states by number of appearances",
    subtitle = paste0(
      "Total = ",
      format(nrow(frogs), big.mark = " ")
    )
  ) |>
  cols_label(
    stateProvince = "State",
    n = "Total"
  ) |>
  data_color(
    columns = c("n"),
    colors = scales::col_numeric(
      palette = c("#FFFFE0", "#FFA500", "#FF0000"),
      domain = NULL
    )
  ) |>
  cols_align(
    align = "center",
    columns = c("n")
  )

sauvegarder_tableau_gt(
  tab_state_ranking,
  "2025-09-02",
  "tab_state_ranking.png"
)


# Genus/species
# Classement par genus/specie
tab_genus_breakdown <- frogs |>
  count(genus, specie) |>
  arrange(desc(n)) |>
  gt(groupname_col = "genus") |>
  tab_header(
    title = "Taxonomic Breakdown of Frog Genera"
  ) |>
  tab_style(
    style = cell_text(align = "center"),
    locations = cells_row_groups()
  ) |>
  tab_style(
    style = cell_fill(color = "lightblue"),
    locations = cells_row_groups()
  ) |>
  data_color(
    columns = c("n"),
    colors = scales::col_numeric(
      palette = c("#FFFFE0", "#FFA500", "#FF0000"),
      domain = NULL
    )
  ) |>
  cols_label(
    genus = "Genus",
    specie = "Specie",
    n = "Total"
  ) |>
  cols_width(
    specie ~ px(200),
    n ~ px(75)
  ) |>
  cols_align(
    align = "center",
    columns = c("n")
  )

sauvegarder_tableau_gt(
  tab_genus_breakdown,
  "2025-09-02",
  "tab_genus_breakdown.png"
)

################################################## Graphiques #################################################
# ID recorder
## Top 10 ID recorder/Observors
ID_recorder_top_10 <- frogs |>
  count(recordedBy) |>
  slice_max(n, n = 10) |>
  arrange(desc(n)) |>
  mutate(
    recordedBy = factor(
      recordedBy,
      levels = recordedBy,
      labels = paste0("Observer ", 1:10)
    )
  )

upper <- max(ID_recorder_top_10$n) + 100

graph_ID_recorder_top_10 <- ID_recorder_top_10 |>
  ggplot(aes(recordedBy, n)) +
  geom_col(fill = "#A6D3ED", color = "black") +
  geom_text(aes(label = n), vjust = -0.5) +
  scale_y_continuous(
    expand = c(0, 0),
    limits = c(0, upper),
    breaks = seq(0, upper, 250)
  ) +
  labs(
    title = "Top 10 people who reported a frog sighting",
    subtitle = paste(
      "Total number of sightings:",
      format(nrow(frogs), big.mark = " ")
    ),
    x = "Observer",
    y = "Total"
  ) +
  custom_theme() +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  )

sauvegarder_graphique_ggplot(
  graph_ID_recorder_top_10,
  "2025-09-02",
  "graph_ID_recorder_top_10.png",
  width = 14,
  height = 10,
  dpi = 400
)

## Heure d'activité du top 5
ID_observers_top_5_hour <- frogs |>
  left_join(y = ID_observers_top_5, by = "recordedBy") |>
  filter(recordedBy %in% ID_observers_top_5$recordedBy) |>
  mutate(hour = hour(hms(eventTime))) %>%
  group_by(Observers, hour) %>%
  summarise(nombre = n(), .groups = "drop")

upper <- max(ID_observers_top_5_hour$nombre) + 50

graph_ID_observers_top_5_hour <- ID_observers_top_5_hour |>
  ggplot(aes(x = hour, y = nombre, color = Observers)) +
  geom_step(linewidth = 2) +
  geom_point(shape = 18, size = 4, alpha = 0.5) +
  scale_x_continuous(breaks = 0:23) +
  scale_y_continuous(
    expand = c(0, 0),
    limits = c(0, upper),
    breaks = seq(0, upper, 50)
  ) +
  scale_color_viridis(discrete = TRUE, option = "D") +
  labs(
    title = "Hourly Activity of Observers",
    subtitle = "Number of occurrences per hour for the top 5 Observers",
    x = "Hour (0-23h)",
    y = "Number of occurrences",
    color = "Observers:"
  ) +
  custom_theme()

sauvegarder_graphique_ggplot(
  graph_ID_observers_top_5_hour,
  "2025-09-02",
  "graph_ID_observers_top_5_hour.png",
  width = 14,
  height = 10,
  dpi = 400
)


# Map
ozmap <- ozmaps::ozmap_country
## Map genus
graph_map_genus <- ggplot(ozmap) +
  geom_sf() +
  geom_point(
    data = frogs,
    aes(x = decimalLongitude, y = decimalLatitude),
    color = "#669b70",
    size = 0.5,
    alpha = 0.7
  ) +
  coord_sf() +
  labs(
    title = "Frog Distribution Area",
    x = "Longitude",
    y = "Latitude"
  ) +
  custom_theme()

sauvegarder_graphique_ggplot(
  graph_map_genus,
  "2025-09-02",
  "graph_map_genus.png",
  width = 10,
  height = 8,
  dpi = 400
)


## Map top 10 genus
top_10_genus <- frogs |>
  group_by(genus) |>
  summarise(count = n()) |>
  slice_max(count, n = 10) |>
  ungroup()

top_10_genus_filtered <- frogs |>
  filter(genus %in% top_10_genus$genus)

graph_map_genus_top_10 <- ggplot(ozmap) +
  geom_sf() +
  geom_point(
    data = top_10_genus_filtered,
    aes(x = decimalLongitude, y = decimalLatitude, colour = genus),
    size = 0.5,
    alpha = 0.6
  ) +
  coord_sf() +
  labs(
    title = "Frog Distribution Area",
    subtitle = "Top 10 Most Observed Genus",
    x = "Longitude",
    y = "Latitude",
    color = "Genus :"
  ) +
  guides(color = guide_legend(override.aes = list(size = 2.5))) +
  custom_theme()

sauvegarder_graphique_ggplot(
  graph_map_genus_top_10,
  "2025-09-02",
  "graph_map_genus_top_10.png",
  width = 10,
  height = 8,
  dpi = 400
)


## Carte superficie genus top 5
### Fonction pour créer une enveloppe concave
create_concave_hull <- function(coords_df, concavity = 2.5) {
  if (!is.data.frame(coords_df)) {
    if (is.list(coords_df) && length(coords_df) == 1) {
      coords_df <- coords_df[[1]]
    } else {
      return(NULL)
    }
  }
  m <- as.matrix(coords_df[,
    c("decimalLongitude", "decimalLatitude"),
    drop = FALSE
  ])
  if (nrow(m) >= 3) {
    hull <- concaveman(m, concavity)
    st_polygon(list(hull))
  } else {
    NULL
  }
}

#### Fonction pour calculer l'aire en km² (avec projection)
calculate_area <- function(polygon) {
  if (!is.null(polygon)) {
    polygon_sf <- st_sf(geometry = st_sfc(polygon), crs = 4326)
    polygon_utm <- st_transform(polygon_sf, 32750) # UTM zone 50S
    st_area(polygon_utm) / 1e6 # Conversion en km²
  } else {
    NA
  }
}

### Filtrer uniquement les points en Australie
aus_frogs <- frogs %>%
  filter(
    decimalLongitude >= 112 &
      decimalLongitude <= 155 &
      decimalLatitude >= -45 &
      decimalLatitude <= -10
  )

### Grouper par genre et calculer les enveloppes concaves et aires
frogs_by_genus_aus <- aus_frogs %>%
  group_by(genus) %>%
  summarise(
    coords = list(data.frame(decimalLongitude, decimalLatitude))
  ) %>%
  mutate(
    concave_hull = lapply(coords, create_concave_hull),
    area_km2 = sapply(concave_hull, calculate_area)
  ) %>%
  filter(!is.na(area_km2)) # Garder uniquement les genres avec une aire valide

### Sélectionner les 5 genres avec la plus grande aire
top_5_genus <- frogs_by_genus_aus %>%
  arrange(desc(area_km2)) %>%
  head(5)

### Créer un objet sf pour les 5 genres
top_5_concave_sf <- st_sf(
  genus = top_5_genus$genus,
  area_km2 = top_5_genus$area_km2,
  geometry = st_sfc(top_5_genus$concave_hull),
  crs = 4326
)

### Récupérer la carte de l'Australie
aus_map <- ozmaps::ozmap_country

### Fonction pour générer une carte par genre
generate_map <- function(genus_name) {
  genus_data <- top_5_concave_sf %>%
    filter(genus == genus_name)

  ggplot() +
    geom_sf(data = aus_map, fill = "lightgray", color = "black") +
    geom_sf(data = genus_data, fill = "darkgreen", alpha = 0.6) +
    scale_x_continuous(name = "Longitude") +
    scale_y_continuous(name = "Latitude") +
    labs(
      title = paste("Distribution of genus", genus_name, "in Australia"),
      subtitle = paste(
        "Area:",
        format(round(genus_data$area_km2, 2), big.mark = " ", trim = TRUE),
        "km²"
      ),
      x = "Longitude",
      y = "Latitude"
    ) +
    custom_theme()
}

### Boucle pour générer et sauvegarder chaque carte
for (genus in top_5_genus$genus) {
  p <- generate_map(genus)
  nom_fichier <- paste0("graph_map_genus_", genus, ".png")

  sauvegarder_graphique_ggplot(
    plot = p,
    date_val = "2025-09-02",
    nom_fichier = nom_fichier,
    width = 10,
    height = 8,
    dpi = 400
  )
}
