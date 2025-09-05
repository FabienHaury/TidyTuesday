<div align="center">

# Billboard Hot 100 Number Ones

</div>

## Introduction et problématique
Pourquoi étudier les Number Ones du Billboard ?   
   1 - Indicateur de succès commercial   
        Le classement Billboard est un baromètre du succès commercial. Analyser les Number Ones permet de voir quels artistes, genres ou labels dominent à une période donnée.    
   2 - Étude sociologique et générationnelle    
        Les chansons qui arrivent en tête du classement peuvent révéler des thèmes récurrents (amour, protestation, fête, etc.) et des préoccupations sociétales (crises, mouvements sociaux, innovations technologiques).    
   3 - Analyse des stratégies marketing et industrielles   
        Atteindre la première place du Billboard est souvent le résultat de stratégies de promotion, de diffusion radio, de streaming, et de vente. C’est un bon cas d’étude pour comprendre l’industrie musicale et ses mécanismes.    
        Et bien d'autres raisons !

        
  ## Questions-clés que nous allons explorer au fil du rapport :
  - Quels artistes sont le plus représentés ?
  - Comment on varié les titres au fil des décennies ?
      - Par note
      - Par longeur
      - Par BPM
  - Quels sont les thématiques de chanson les plus représentés ?
  - Quels sont les lables les plus représenté ?

---

## Données
[Données](https://github.com/rfordatascience/tidytuesday/blob/main/data/2025/2025-08-26/readme.md)   
Une explication complête pour chaque colonnes du jeu de données est disponibles en suivant le lien ci-dessus.   

---

## Méthodologies
Les principales colonnes utilisées sont les suivantes :
- song : Nom de la chanson.
- artist : Nom du ou des artistes.
- weeks_at_number_one : Total des semaines au top 1.
- overall_rating : Note moyenne.
- label : Label qui à publié la chanson.
- parent_label : Maison de disque propriétaire de label.
- talent_contestant : Si l'artiste a participé à un télé-crochet.
- bpm : Beat par minutes.
- length_sec : Durée en seconde de la chanson.
- lyrical_topic : Sujet principal des paroles.

Un traitement léger des données est effectuer avec la création d'une nouvelle colonne "decade" à partir de la colonne "year", ainsi que la création de la catégorie 'Non' dans la colonne talent_contestant en remplacant les données NA.

---
![Résume](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Billboard%20Hot%20100%20Number%20Ones/Plots/Tableaux/tab_summary_decade.png)
![Artiste](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Billboard%20Hot%20100%20Number%20Ones/Plots/Graphiques/graph_top_10_artist.png)
![Rating](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Billboard%20Hot%20100%20Number%20Ones/Plots/Graphiques/graph_max_min_rating.png)
