<div align="center">

# Billboard Hot 100 Number Ones

</div>

- [Introduction](#introduction-et-problématique)  
- [Données](#données)  
- [Méthodologies](#méthodologies)  
- [Analyse générale](#i-analyse-générale)  
- [Artistes marquants](#ii-analyse-des-artistes-et-œuvres-marquantes)  
- [Labels et industrie](#iii-analyse-des-succès-et-de-lindustrie-musicale)  
- [Thématiques](#iv-thématiques-contents-et-évolution-qualitative)





## Introduction et problématique  

Pourquoi étudier les *Number Ones* du Billboard ?  

1. **Indicateur de succès commercial**  
   Le classement *Billboard Hot 100* est un baromètre du succès commercial.  
   Analyser les *Number Ones* permet de voir quels artistes, genres ou labels dominent à une période donnée.    

2. **Étude sociologique et générationnelle**  
   Les chansons qui arrivent en tête du classement peuvent révéler des thèmes récurrents (amour, protestation, fête, etc.) et refléter les préoccupations sociétales (crises, mouvements sociaux, innovations technologiques).    

3. **Analyse des stratégies marketing et industrielles**  
   Atteindre la première place du Billboard est souvent le résultat de stratégies de promotion (diffusion radio, campagnes marketing, streaming, ventes).  
   C’est un excellent cas d’étude pour comprendre l’industrie musicale et ses mécanismes.  

Et bien d’autres raisons encore !  

### Questions-clés explorées dans ce rapport  

- Quels artistes sont les plus représentés ?  
- Comment les titres ont-ils varié au fil des décennies ?  
  - Par note  
  - Par durée  
  - Par BPM  
- Quels sont les thèmes de chansons les plus présents ?  
- Quels sont les labels les plus représentés ?  

---

## Données  

[Données](https://github.com/rfordatascience/tidytuesday/blob/main/data/2025/2025-08-26/readme.md)  

Une explication complète de chaque colonne du jeu de données est disponible en suivant le lien ci-dessus.  

---

## Méthodologies  

Les principales colonnes utilisées sont les suivantes :  

- **song** : Nom de la chanson  
- **artist** : Nom du ou des artistes  
- **weeks_at_number_one** : Total des semaines au top 1  
- **overall_rating** : Note moyenne  
- **label** : Label qui a publié la chanson  
- **parent_label** : Maison de disque propriétaire du label  
- **talent_contestant** : Si l’artiste a participé à un télé-crochet  
- **bpm** : Battements par minute  
- **length_sec** : Durée en secondes de la chanson  
- **lyrical_topic** : Sujet principal des paroles  

Un traitement léger des données est effectué avec :  
- La création d’une nouvelle colonne `decade` à partir de la colonne `year`.  
- La création de la catégorie *Non* dans la colonne `talent_contestant` en remplaçant les valeurs manquantes (NA).  

---

## Analyse   

### I. Analyse générale    

**Statistiques majeures par décennie** : nombre de titres, durée moyenne, BPM moyen, note moyenne  

![](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Billboard%20Hot%20100%20Number%20Ones/Plots/Tableaux/tab_summary_decade.png)  

- [Graphique résumé par décennie](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Billboard%20Hot%20100%20Number%20Ones/Plots/Graphiques/graph_summary_decade.png)  
- [Graphique note moyenne par décennie](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Billboard%20Hot%20100%20Number%20Ones/Plots/Graphiques/graph_rating_decade.png)  
- [Graphique durée moyenne par décennie](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Billboard%20Hot%20100%20Number%20Ones/Plots/Graphiques/graph_length_decade.png)  
- [Graphique BPM moyen par décennie](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Billboard%20Hot%20100%20Number%20Ones/Plots/Graphiques/graph_bpm_decade.png)  

#### Points à retenir :  

1. **Décennies incomplètes (1950 et 2020)**  
   Le faible nombre d’entrées dans les **années 1950** s’explique par le fait que le classement *Billboard Hot 100* n’existe que depuis **1958**.  
   De même, la **décennie 2020** étant encore en cours, son analyse reste nécessairement partielle.  

2. **Deux périodes fortes de notes moyennes élevées**  
   On distingue deux périodes particulièrement favorables à la qualité critique des titres, avec des notes moyennes supérieures à 6.  
   - La première correspond aux **années 1960-1970**, âge d’or de la pop et du rock (Beatles, Motown, chansons contestataires).  
   - La seconde concerne les **années 2000-2010**, marquées par l’essor du R&B, du hip-hop et de la pop mondiale.  
   Ces deux périodes apparaissent ainsi comme des *pics d’innovation et d’influence* dans l’histoire des *Number Ones*.  

3. **Durée moyenne des chansons**  
   La durée moyenne des titres a augmenté de façon constante depuis les **années 1950**, atteignant un pic dans les **années 1990**, avant de diminuer ensuite.  
   - À la fin des **années 1990**, l’essor du **CD** modifie la logique commerciale : pour maximiser la rentabilité des albums, les labels privilégient davantage de morceaux, ce qui peut inciter à réduire la durée des titres.  
   - À partir de la fin des **années 2000**, la montée du **streaming** puis sa suprématie dans les **années 2010 et 2020** renforcent cette tendance : les chansons sont plus courtes, pensées pour maximiser le nombre d’écoutes et limiter le risque de *skip*.  

4. **Évolution du BPM**  
   Le BPM moyen est resté relativement stable sur l’ensemble de la période, mais on observe depuis les **années 2010** une légère accélération.  
   Cette hausse reflète l’influence de genres dansants comme l’**EDM**, la **pop électro** ou encore le **reggaeton**, qui ont contribué à dynamiser le tempo moyen des hits récents.  

---

### Transition vers la suite  

Après avoir identifié les **grandes tendances par décennie** — que ce soit en termes de notes moyennes, de durée, de BPM ou encore de couverture temporelle — nous disposons désormais d’une vision d’ensemble de l’évolution des *Number Ones* du *Billboard Hot 100*.  

Pour aller plus loin, il est essentiel de s’intéresser non plus uniquement aux chiffres globaux, mais aussi aux **artistes et aux chansons qui ont marqué l’histoire** du classement.  

C’est l’objet de la section suivante.  

---

## II. Analyse des artistes et œuvres marquantes

- Répartition des artistes les plus présents  
  ![](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Billboard%20Hot%20100%20Number%20Ones/Plots/Graphiques/graph_top_10_artist.png)
  [Classement des artistes](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Billboard%20Hot%20100%20Number%20Ones/Plots/Tableaux/tab_artist.png)

  Les Beatles domine le billboard avec 20 apparitions sur seulement six ans (1964-1970) soit en moyenne entre trois et quatre chansons atteigant le top 1 par ans !    
  Taylor Swift est la seule artiste dans ce classement n'ayant aucune apparition avant les années 2000 avec sa première apparition en 2012.    
  Seules Madonna et Janet Jackson apparaissent avant et pendant les années 2000.
  Il faut noté qu'être dans le haut du classement ne signifie pas avoir longévité au top 1 avec en moyenne seulement trois semaines à ce niveau.
- Focus sur la constance des succès
  ![](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Billboard%20Hot%20100%20Number%20Ones/Plots/Graphiques/graph_top_10_cons%C3%A9cutif.png)
  ![](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Billboard%20Hot%20100%20Number%20Ones/Plots/Graphiques/graph_top_10_non_cons%C3%A9cutif.png)


  
- Analyse de l’origine ou diversité géographique des artistes  
  ![](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Billboard%20Hot%20100%20Number%20Ones/Plots/Graphiques/graph_top_10_origine.png)
  Ce graphique répresente la nationalité du (bi-nationale) ou des artistes.

---
<!-- 
## III. Analyse des succès et de l’industrie musicale

- Répartition par label et maison de disque  
  (*tab_parent_label.png*)  
- Commentaires sur le poids des majors et l’indépendance éventuelle  

---

## IV. Thématiques, contenus et évolution qualitative

- Analyse des thèmes des chansons via les paroles  
  (*tab_parole.png*)  
- Synthèse sur l’évolution des ratings/notes  
- Zoom sur les meilleures et pires performances  
  (*graph_max_min_rating.png*, *graph_rating_line.png*)  
-->

