<div align="center">

# Billboard Hot 100 Number Ones

</div>

## Sommaire
- [Introduction et problématique](#introduction-et-problématique)  
- [Données](#données)  
- [Méthodologies](#méthodologies)  
- [Analyse générale](#i-analyse-générale)  
- [Artistes marquants](#ii-analyse-des-artistes-et-œuvres-marquantes)  
- [Labels et industrie](#iii-analyse-des-succès-et-de-lindustrie-musicale)  
- [Thématiques](#iv-thématiques-et-évolution-qualitative)
- [Conclusion](#conclusion) 

---

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
   Le classement *Billboard Hot 100* n’existe que depuis **1958** → peu de données pour les années 1950.  
   La décennie 2020 est encore en cours → analyse partielle.  

2. **Deux pics de notes critiques élevées**  
   - **1960-1970** : âge d’or pop/rock (Beatles, Motown, contestation).  
   - **2000-2010** : essor R&B, hip hop, pop mondiale → notes critiques supérieures à 6.  

3. **Durée moyenne des chansons**  
   - Hausse continue jusqu’aux **années 1990** (période CD).  
   - Baisse structurelle depuis le **streaming** (2000-2020) → titres conçus pour être plus courts et éviter le *skip*.  

4. **Évolution du BPM**  
   BPM stable dans l’ensemble, mais accélération depuis **2010** → influence dance/EDM/reggaeton.  

---

### Transition vers la section II   
Après avoir identifié les grandes tendances par décennie, il est temps de zoomer sur les artistes et chansons emblématiques qui incarnent ces évolutions.

---

## II. Analyse des artistes et œuvres marquantes  

### II.1. Les artistes les plus représentés  

![](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Billboard%20Hot%20100%20Number%20Ones/Plots/Graphiques/graph_top_10_artist.png)  
[Classement complet des artistes](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Billboard%20Hot%20100%20Number%20Ones/Plots/Tableaux/tab_artist.png)  

- **The Beatles** : 20 titres n°1 en seulement 6 ans (1964–1970) → domination fulgurante, sans équivalent.  
- **Mariah Carey** : modèle de carrière longue, avec des hits saisonniers comme *All I Want for Christmas Is You*.  
- **Taylor Swift** : arrivée en 2012, déjà parmi les + présents → stratégie fanbase & streaming.  
- **Madonna et Janet Jackson** : longévité rare, de MTV (80s–90s) jusqu’aux années 2000.  

---

### II.2. Constance et longévité des succès  

![](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Billboard%20Hot%20100%20Number%20Ones/Plots/Graphiques/graph_top_10_cons%C3%A9cutif.png)  
![](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Billboard%20Hot%20100%20Number%20Ones/Plots/Graphiques/graph_top_10_non_cons%C3%A9cutif.png)  

- **Beatles** → multi-hits rapides, mais durées courtes (3–4 semaines).  
- **Whitney Houston**, **Boyz II Men**, **Lil Nas X** (*Old Town Road*) → titres-marathons, plusieurs mois au #1.  
- Deux modèles de domination :  
  - *Multi-hits répétés mais courts* (Beatles, Rihanna, Drake, Taylor Swift).  
  - *Phénomènes ponctuels ultra-dominants* (Whitney Houston, Luis Fonsi, Lil Nas X).  

---

### II.3. Diversité géographique et mondialisation  

![](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Billboard%20Hot%20100%20Number%20Ones/Plots/Graphiques/graph_top_10_origine.png)  

- La majorité des artistes restent **américains** (logique classement US).  
- Mais certains pôles émergent :  
  - **Royaume-Uni** : Beatles, Elton John, Adele, Ed Sheeran.  
  - **Canada** : Drake, The Weeknd, Justin Bieber.  
  - **Monde hispanophone** : Shakira, Luis Fonsi, Bad Bunny → mondialisation et succès du reggaeton.  

---

### Transition vers la section III  
L’analyse des artistes révèle différents modèles de succès :  
- *Domination courte mais massive* (Beatles).  
- *Longévité soutenue* (Mariah Carey, Madonna, Janet Jackson).  
- *Phénomènes mondiaux ponctuels* (Whitney Houston, Lil Nas X).  
- *Globalisation accrue* (Drake, Shakira, Luis Fonsi).  

L’analyse des artistes révèle différents modèles de succès et montre l’influence croissante de la mondialisation. Il convient à présent de comprendre l’envers du décor industriel : quels labels et majors façonnent ces succès et quelle place occupent les indépendants ?

---


## III. Analyse des succès et de l’industrie musicale  
![](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Billboard%20Hot%20100%20Number%20Ones/Plots/Tableaux/tab_top_10_parent_label.png)
![](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Billboard%20Hot%20100%20Number%20Ones/Plots/Tableaux/tab_top_10_label.png)
![](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Billboard%20Hot%20100%20Number%20Ones/Plots/Tableaux/tab_top_10_parent_label_label.png)   

[Total des labels détenus par les maisons de disques](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Billboard%20Hot%20100%20Number%20Ones/Plots/Tableaux/tab_label_detention.png)    
[Classement par maison de disque, leur labels respectif par décennie](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Billboard%20Hot%20100%20Number%20Ones/Plots/Tableaux/tab_parent_label.png)

- **Trois majors dominantes** : Sony, Warner Bros., Universal (Vivendi).  
- **Columbia** tire particulièrement son épingle du jeu, avec plus de 100 apparitions.  
- Changements de propriétaires visibles sur le temps (ex. Columbia : CBS → Sony).


### Transition vers la section IV
L’analyse des maisons de disques met en évidence leur rôle central dans les succès du Billboard Hot 100. Abordons désormais le contenu même des chansons, avec une exploration des thématiques, des enjeux qualitatifs et des évolutions portées par ces titres numéro un.

---
## IV. Thématiques et évolution qualitative  
  ### IV.1. Thématiques des chansons
  ![](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Billboard%20Hot%20100%20Number%20Ones/Plots/Tableaux/tab_top_10_parole.png)    
  [Classement complet des thématiques](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Billboard%20Hot%20100%20Number%20Ones/Plots/Tableaux/tab_parole.png)   
  - Amour, sexe, relations = thèmes centraux.
  - - La récurrence ≠ longévité.


  ### IV.2. Evolution des notes
  ![](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Billboard%20Hot%20100%20Number%20Ones/Plots/Graphiques/graph_rating_line.png)
  ![](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Billboard%20Hot%20100%20Number%20Ones/Plots/Graphiques/graph_max_min_rating.png)   
  - Pic absolu en **1964**. Creux en **1990**.
  - Années 60-80 → extrêmes (notes de 1 à 10).
  - Années 2000+ → notes plus lissées.

---

## Conclusion  

L’analyse des *Billboard Hot 100 Number Ones* met en évidence :  
- **Évolution des formats** : plus court depuis le streaming, plus rapide (BPM).  
- **Dynamiques artistiques** : Beatles → domination rapide, Carey & Swift → longévité.  
- **Industrie centralisée** : domination persistante des majors.  
- **Miroir sociologique** : amour reste le thème dominant, mais la mondialisation a ouvert le classement à de nouvelles influences (reggaeton, artistes globaux).  

---

## Contact

Projet mené dans le cadre de mon Diplôme Universitaire Data Analyst par Cergy Paris Université (2022).   
Pour me contacter : 
- [email](mailto:67912775+FabienHaury@users.noreply.github.com)
