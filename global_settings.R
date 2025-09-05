# Load required libraries
library(ggplot2)
library(ggthemes)

# Load fonts
extrafont::loadfonts(device = "win", quiet = TRUE)

# Global settings
Sys.setlocale("LC_TIME", "C")
options(scipen = 999)


################################ custom_theme ################################
#' Thème personnalisé ggplot2 pour tous les graphiques
#'
#' Définit un thème basé sur theme_bw() avec des polices Arial personnalisées pour titres, axes et légendes.
#' @return Un objet thème ggplot2
custom_theme <- function() {
  theme_bw() +
    theme(
      text = element_text(family = "Arial", size = 12),
      axis.title = element_text(size = 16),
      axis.text = element_text(size = 12),
      plot.title = element_text(
        size = 20,
        face = "bold",
        margin = margin(b = 5),
        hjust = 0.5
      ),
      plot.subtitle = element_text(
        size = 16,
        margin = margin(b = 5),
        hjust = 0.5
      ),
      legend.text = element_text(size = 10),
      legend.title = element_text(size = 12),
      axis.title.x = element_text(margin = margin(t = 15)),
      axis.title.y = element_text(margin = margin(r = 15)),
    )
}

# Set the custom theme as the default theme
theme_set(custom_theme())


################################ creer_dossiers_date_et_graphique ################################
#' Crée les dossiers de date et Graphique_tableau s'ils n'existent pas
#'
#' @param date_val Date ou chaîne "AAAA-MM-JJ" pour le dossier parent
#' @param base_dossier Chemin vers dossier de base (défaut "C:/Users/fabie/Documents/R things/Tidytuesday/Date")
#' @return Chemin complet du sous-dossier Graphique_tableau
creer_dossiers_date_et_graphique <- function(
  date_val,
  base_dossier = "C:/Users/fabie/Documents/R things/Tidytuesday/Date"
) {
  if (inherits(date_val, "Date")) {
    date_str <- format(date_val, "%Y-%m-%d")
  } else {
    date_str <- as.character(date_val)
  }

  dossier_date <- file.path(base_dossier, date_str)
  dossier_graphique <- file.path(dossier_date, "Graphique_tableau")

  if (!dir.exists(dossier_date)) {
    dir.create(dossier_date, recursive = TRUE)
    message("Dossier de date créé : ", dossier_date)
  } else {
    message("Le dossier de date existe déjà : ", dossier_date)
  }

  if (!dir.exists(dossier_graphique)) {
    dir.create(dossier_graphique, recursive = TRUE)
    message("Sous-dossier Graphique_tableau créé : ", dossier_graphique)
  } else {
    message(
      "Le sous-dossier Graphique_tableau existe déjà : ",
      dossier_graphique
    )
  }

  return(dossier_graphique)
}

################################ Sauvegarder tableaux ################################
#' Sauvegarde un tableau gt dans le dossier Graphique_tableau correspondant à la date donnée
#'
#' @param tab Objet tableau gt à sauvegarder
#' @param date_val Date ou chaîne "AAAA-MM-JJ" utilisée pour déterminer le dossier de sauvegarde
#' @param nom_fichier Nom du fichier de sauvegarde (doit être fourni, sans valeur par défaut)
#' @param forcer Booléen, si TRUE écrase le fichier existant (défaut FALSE)
#' @return TRUE si sauvegarde effectuée, FALSE si le fichier existait déjà et n'a pas été écrasé
#' @throws Arrête avec message d'erreur si nom_fichier non fourni ou vide
sauvegarder_tableau_gt <- function(tab, date_val, nom_fichier, forcer = FALSE) {
  if (missing(nom_fichier) || nom_fichier == "") {
    stop("Erreur : veuillez fournir un nom de fichier valide.")
  }

  dossier <- creer_dossiers_date_et_graphique(date_val)
  chemin_fichier <- file.path(dossier, nom_fichier)

  if (file.exists(chemin_fichier) && !forcer) {
    message(
      "Le fichier existe déjà : ",
      chemin_fichier,
      " - sauvegarde ignorée."
    )
    return(FALSE)
  }

  gtsave(tab, chemin_fichier)
  message("Tableau sauvegardé dans : ", chemin_fichier)
  return(TRUE)
}

################################ sauvegarder graphique ggplot ################################
#' Sauvegarde un graphique ggplot2 dans un dossier structuré par date
#'
#' @param plot Objet graphique ggplot2 à sauvegarder
#' @param date_val Date ou chaîne "AAAA-MM-JJ" utilisée pour déterminer le dossier de sauvegarde
#' @param nom_fichier Nom du fichier de sauvegarde (doit être fourni, avec extension)
#' @param width Largeur du graphique en pouces (défaut 8)
#' @param height Hauteur du graphique en pouces (défaut 8)
#' @param dpi Résolution en points par pouce (défaut 300)
#' @param forcer Booléen, si TRUE écrase le fichier existant (défaut FALSE)
#' @return TRUE si la sauvegarde est effectuée, FALSE si le fichier existait déjà et n'a pas été écrasé
#' @throws Arrête avec message d'erreur si nom_fichier non fourni ou vide
#'
#' Cette fonction utilise ggplot2::ggsave pour exporter un graphique avec contrôle des dimensions et de la résolution.
#' Elle vérifie la présence du fichier pour éviter d'écraser sans demande, sauf si 'forcer' est TRUE.
#' Le dossier est automatiquement créé selon la date fournie via la fonction 'creer_dossiers_date_et_graphique'.
sauvegarder_graphique_ggplot <- function(
  plot,
  date_val,
  nom_fichier,
  width = 8,
  height = 8,
  dpi = 300,
  forcer = FALSE
) {
  if (missing(nom_fichier) || nom_fichier == "") {
    stop("Erreur : veuillez fournir un nom de fichier valide.")
  }

  dossier <- creer_dossiers_date_et_graphique(date_val)
  chemin_fichier <- file.path(dossier, nom_fichier)

  if (file.exists(chemin_fichier) && !forcer) {
    message(
      "Le fichier existe déjà : ",
      chemin_fichier,
      " - sauvegarde ignorée."
    )
    return(FALSE)
  }

  ggplot2::ggsave(
    filename = chemin_fichier,
    plot = plot,
    width = width,
    height = height,
    dpi = dpi
  )

  message("Graphique sauvegardé dans : ", chemin_fichier)
  return(TRUE)
}
