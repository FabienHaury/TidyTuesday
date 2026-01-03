<div align="center">
   
# Billboard Hot 100 Number Ones

</div>

## Table of Contents
- [Introduction and Problematic](#introduction-and-problematic)  
- [Data](#data)  
- [Methodologies](#methodologies)  
- [General Analysis](#i-general-analysis)  
- [Prominent Artists](#ii-analysis-of-artists-and-notable-works)  
- [Labels and Industry](#iii-analysis-of-success-and-the-music-industry)  
- [Themes](#iv-themes-and-qualitative-evolution)  
- [Conclusion](#conclusion)  

---

## Introduction and Problematic  
Why study the *Number Ones* of Billboard?  
1. **Commercial success indicator**  
   The *Billboard Hot 100* chart is a barometer of commercial success.  
   Analyzing *Number Ones* shows which artists, genres, or labels dominate during a given period.  
2. **Sociological and generational study**  
   Songs reaching the top reveal recurring themes (love, protest, party, etc.) and mirror societal concerns (crises, social movements, technological innovations).  
3. **Analysis of marketing and industry strategies**  
   Reaching Billboard #1 is often the result of promotion strategies (radio airplay, marketing campaigns, streaming, sales).  
   It's an excellent case study to understand the music industry and its mechanics.  
And many more reasons!  

### Key questions explored in this report  
- Which artists are most represented?  
- How have songs varied over the decades?  
  - By rating  
  - By length  
  - By BPM  
- What are the most frequent song themes?  
- Which labels are most represented?  

---

## Data  
[Data details and dictionary](https://github.com/rfordatascience/tidytuesday/blob/main/data/2025/2025-08-26/readme.md)  
A full explanation of each dataset column is available at the link above.  

---

## Methodologies  
Key columns used include:  
- **song**: Song title  
- **artist**: Artist(s) name  
- **weeks_at_number_one**: Total weeks at #1  
- **overall_rating**: Average rating  
- **label**: Label that published the song  
- **parent_label**: Major record company owning the label  
- **talent_contestant**: If artist participated in a TV talent show  
- **bpm**: Beats per minute  
- **length_sec**: Song duration in seconds  
- **lyrical_topic**: Main lyrical topic  

Data processing includes:  
- Creation of a new column `decade` from the `year` column.  
- Adding a *No* category in `talent_contestant` replacing missing (NA) values.  

---

## Analysis  
### I. General Analysis  
**Major statistics by decade**: number of songs, average duration, average BPM, average rating  
![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Billboard%20Hot%20100%20Number%20Ones/Plots/Tableaux/tab_summary_decade.png)  
- [Summary chart by decade](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Billboard%20Hot%20100%20Number%20Ones/Plots/Graphiques/graph_summary_decade.png)  
- [Average rating by decade](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Billboard%20Hot%20100%20Number%20Ones/Plots/Graphiques/graph_rating_decade.png)  
- [Average duration by decade](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Billboard%20Hot%20100%20Number%20Ones/Plots/Graphiques/graph_length_decade.png)  
- [Average BPM by decade](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Billboard%20Hot%20100%20Number%20Ones/Plots/Graphiques/graph_bpm_decade.png)  

#### Key takeaways:  
1. **Incomplete decades (1950 and 2020)**  
   The *Billboard Hot 100* only exists since **1958** → few data for the 1950s.  
   The 2020 decade is ongoing → partial analysis.  
2. **Two peaks of high critical ratings**  
   - **1960-1970**: golden age of pop/rock (Beatles, Motown, protest).  
   - **2000-2010**: rise of R&B, hip hop, global pop → ratings above 6.  
3. **Average song duration**  
   - Continuous rise until the **1990s** (CD era).  
   - Structural drop since **streaming** (2000-2020) → shorter songs to prevent skips.  
4. **BPM evolution**  
   Overall stable BPM, but acceleration since **2010** → dance/EDM/reggaeton influence.  

---

### Transition to section II  
After identifying major decade trends, it’s time to zoom in on emblematic artists and songs embodying these evolutions.  

---

## II. Analysis of Artists and Notable Works  
### II.1. Most represented artists  
![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Billboard%20Hot%20100%20Number%20Ones/Plots/Graphiques/graph_top_10_artist.png)  
[Full ranking of artists](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Billboard%20Hot%20100%20Number%20Ones/Plots/Tableaux/tab_artist.png)  
- **The Beatles**: 20 #1 hits in only 6 years (1964–1970) → unparalleled dominance.  
- **Mariah Carey**: long career model with seasonal hits like *All I Want for Christmas Is You*.  
- **Taylor Swift**: debut in 2012, already among the most frequent → fanbase & streaming strategy.  
- **Madonna and Janet Jackson**: rare longevity, MTV era (80s–90s) to 2000s.  

---

### II.2. Consistency and longevity of success  
![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Billboard%20Hot%20100%20Number%20Ones/Plots/Graphiques/graph_top_10_cons%C3%A9cutif.png)  
![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Billboard%20Hot%20100%20Number%20Ones/Plots/Graphiques/graph_top_10_non_cons%C3%A9cutif.png)  
- **Beatles** → quick multi-hits with short durations (3–4 weeks).  
- **Whitney Houston**, **Boyz II Men**, **Lil Nas X** (*Old Town Road*) → marathon songs with several months at #1.  
- Two models of dominance:  
  - *Repeated short multi-hits* (Beatles, Rihanna, Drake, Taylor Swift).  
  - *Ultra-dominant one-off phenomena* (Whitney Houston, Luis Fonsi, Lil Nas X).  

---

### II.3. Geographic diversity and globalization  
![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Billboard%20Hot%20100%20Number%20Ones/Plots/Graphiques/graph_top_10_origine.png)  
- Most artists remain **American** (logical for a US chart).  
- Emerging hubs:  
  - **UK**: Beatles, Elton John, Adele, Ed Sheeran.  
  - **Canada**: Drake, The Weeknd, Justin Bieber.  
  - **Hispanic world**: Shakira, Luis Fonsi, Bad Bunny → globalization and reggaeton success.  

---

### Transition to section III  
Artist analysis reveals success patterns:  
- *Short but massive domination* (Beatles).  
- *Sustained longevity* (Mariah Carey, Madonna, Janet Jackson).  
- *Occasional global phenomena* (Whitney Houston, Lil Nas X).  
- *Increased globalization* (Drake, Shakira, Luis Fonsi).  
Next, analyze the music industry’s role: which labels and majors shape these successes and what is the independents’ place?  

---

## III. Analysis of Success and the Music Industry  
![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Billboard%20Hot%20100%20Number%20Ones/Plots/Tableaux/tab_top_10_parent_label.png)  
![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Billboard%20Hot%20100%20Number%20Ones/Plots/Tableaux/tab_top_10_label.png)  
![](https://github.com/FabienHaury/TidyTuesday/tree/main/Data%20analysis/Billboard%20Hot%20100%20Number%20Ones/Plots/Tableaux)  
[Total labels owned by record companies](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Billboard%20Hot%20100%20Number%20Ones/Plots/Tableaux/tab_label_detention.png)  
[Ranking by major label and their respective labels by decade](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Billboard%20Hot%20100%20Number%20Ones/Plots/Tableaux/tab_parent_label.png)  
- **Three dominant majors**: Sony, Warner Bros., Universal (Vivendi).  
- **Columbia** stands out with over 100 appearances.  
- Ownership changes evident over time (e.g., Columbia: CBS → Sony).

---

### Transition to section IV  
The analysis of record companies highlights their central role in Billboard Hot 100 successes. Now we explore song content itself — themes, qualitative challenges, and evolutions in number ones.  

---

## IV. Themes and Qualitative Evolution  
### IV.1. Song themes  
![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Billboard%20Hot%20100%20Number%20Ones/Plots/Tableaux/tab_top_10_parole.png)  
[Full theme ranking](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Billboard%20Hot%20100%20Number%20Ones/Plots/Tableaux/tab_parole.png)  
- Love, sex, relationships = central themes.  
- Recurrence ≠ longevity.  

### IV.2. Evolution of ratings  
![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Billboard%20Hot%20100%20Number%20Ones/Plots/Graphiques/graph_rating_line.png)  
![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Billboard%20Hot%20100%20Number%20Ones/Plots/Graphiques/graph_max_min_rating.png)  
- Absolute peak in **1964**, trough in **1990**.  
- 60s-80s → extremes (ratings from 1 to 10).  
- 2000s+ → smoother ratings.  

---

## Conclusion  
The analysis of *Billboard Hot 100 Number Ones* highlights:  
- **Format evolution**: shorter since streaming, faster (BPM).  
- **Artist dynamics**: Beatles → rapid domination, Carey & Swift → longevity.  
- **Centralized industry**: persistent major dominance.  
- **Sociological mirror**: love remains dominant, globalization opened charts to new influences (reggaeton, global artists).  

---

## Contact  
- 📧 [Email](mailto:67912775+FabienHaury@users.noreply.github.com)  
- 💼 [LinkedIn](https://www.linkedin.com/in/fabienhaury/)
