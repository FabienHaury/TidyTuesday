<div align="center">
   
# Australian frogs

</div>

## Table of contents
- [Introduction and problematic](#introduction-and-problematic)  
- [Data](#data)  
- [Methodologies](#methodologies)  
- [Analysis](#analysis)  
- [Conclusion](#conclusion)

---
## Introduction and problematic
### Why study the *FrogID* dataset?  
1. **Biodiversity and conservation insights**  
   FrogID offers a nationwide view of frog populations, helping track species diversity and declines across Australia.  
2. **Climate and environmental monitoring**  
   Frogs are sensitive indicators of environmental changes (e.g., drought, habitat loss, disease). Their calls reveal how ecosystems respond to threats.  
3. **Citizen science at scale**  
   Tens of thousands of recordings from the public enable large-scale studies otherwise impossible for a single research team.  

**Challenges**  
- Uneven sampling (when and where people record) can bias the data.  
- Varied species detectability complicates comparisons.  

This analysis explores what patterns emerge—and what we can and cannot learn—from this unique ecological resource.  

### Key questions explored in this report
- What is the geographical distribution of frog observations?  
- Which genus and species are the most common?  
- Who are the observers?  
  - Which genus do observers report most frequently?  
  - During which time periods are most observations recorded?  

### Difference between genus and species    
Genus and species are fundamental units of biological classification. The **genus** groups species that are closely related and share common traits, while the **species** pinpoints a single distinct organism within that genus. For instance, in *Litoria caerulea* (Australian green tree frog), *Litoria* is the genus and *caerulea* is the species. *A useful way to think of this is like a family name and a first name: the genus is the broader "family name" shared with relatives, while the species is the "first name" that identifies the individual organism more precisely.* This distinction helps scientists organize biodiversity and compare patterns across different taxonomic levels.  

---
## Data  
[Data details and dictionary](https://github.com/rfordatascience/tidytuesday/blob/main/data/2025/2025-09-02/readme.md)  
A full explanation of each dataset column is available at the link above.  

---
## Methodologies  
Key columns used include:  
- **recordedBy**: Observer ID  
- **scientificName**: Scientific frog name  
- **genus**: Genus name  
- **species**: Species name  
- **stateProvince**: Australian state  
- **eventTime**: Time when the event was recorded  
- **decimalLongitude**: Longitudinal coordinate  
- **decimalLatitude**: Latitudinal coordinate  

Data processing includes:  
- Splitting `scientificName` into `genus` and `species` columns  
- Converting the type to integer for `occurrenceID`, `eventID`, and `recordedBy`  

---
## Analysis
### Geographical distribution of observations
The FrogID dataset provides wide coverage across Australia, but observations are unevenly distributed.  
- States differ significantly in the number of submitted records.  
- Urban and accessible areas are over-represented, while remote regions show fewer reports.  

![State ranking of frog observations](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Australian%20Frogs/Plots/Tableaux/tab_state_ranking.png)  

Mapping frog genera reveals distinct distributions. Coastal regions and wetter zones host more frequent calls, while drier inland regions support fewer records.  

![Genus mapping across Australia](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Australian%20Frogs/Plots/Graphiques/graph_map_genus.png)  

Focus on specific genera shows unique spatial trends:  
- *Crinia* is reported widely across Australia except for the central arid areas, reflecting its broad distribution and adaptability to many habitats.  
- *Litoria* species occur commonly along coastal zones but are also found in diverse inland regions throughout the country.  
- *Limnodynastes*, *Pseudophryne*, and *Neobatrachus* each dominate particular habitats.  

<figure>
  <img src="https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Australian%20Frogs/Plots/Graphiques/graph_map_genus_Crinia.png" alt="Crinia distribution">
  <img src="https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Australian%20Frogs/Plots/Graphiques/graph_map_genus_Litoria.png" alt="Litoria distribution">
  <img src="https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Australian%20Frogs/Plots/Graphiques/graph_map_genus_Limnodynastes.png" alt="Limnodynastes distribution">
  <img src="https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Australian%20Frogs/Plots/Graphiques/graph_map_genus_Neobatrachus.png" alt="Neobatrachus distribution">
  <img src="https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Australian%20Frogs/Plots/Graphiques/graph_map_genus_Pseudophryne.png" alt="Pseudophryne distribution">
  <figcaption><em>Note:</em> The areas depicted in these maps represent spatial extents calculated using a <strong>concave hull</strong> of latitude and longitude points where each genus was recorded. This method better follows the shape of recorded points compared to a convex hull, but the mapped areas may still include parts of the landscape where frogs do not occur, as the hull connects outer points to include intermediate regions without confirmed observations.</figcaption>
</figure>

---
### Most common genus and species
Some genera dominate the FrogID dataset both in abundance and geographic spread.  
- *Litoria* and *Crinia* are reported most frequently.  
- Other common genera include *Limnodynastes*, *Neobatrachus*, and *Pseudophryne*.  

[Genus breakdown](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Australian%20Frogs/Plots/Tableaux/tab_genus_breakdown.png)  

![Top genera distribution](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Australian%20Frogs/Plots/Graphiques/graph_map_genus_top_10.png)  

These patterns may reflect both ecological abundance and call detectability, as some frogs vocalize more readily or loudly than others.

---
### Observers and citizen science patterns
Citizen contributions drive the dataset, yet participation is uneven.  
- A few dedicated individuals—“super-observers”—provide a large share of the recordings.  
- Many contributors record only once or a handful of times.  

![Top 5 observers](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Australian%20Frogs/Plots/Tableaux/tab_ID_observers_top_5.png)  
![Top 10 recorders](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Australian%20Frogs/Plots/Graphiques/graph_ID_recorder_top_10.png)  

Time-of-day analysis highlights when frog calls are most likely to be recorded. Predictably, the majority occur during evening and night periods.  

![Top 5 observers by hour](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/Australian%20Frogs/Plots/Graphiques/graph_ID_observers_top_5_hour.png)  

---
### Broader insights and limitations
Overall, the FrogID dataset reveals clear ecological and citizen science patterns:  
- Frog diversity peaks in wetter coastal regions.  
- A handful of genera dominate the dataset.  
- Citizen science participation is skewed, with a small group contributing disproportionately.  

Limitations remain:  
- Data reflect *where people record frogs*, not necessarily where frogs occur.  
- Some species are easier to detect by call.  
- Seasonal and climatic variability influence recording opportunities.  

Despite these challenges, FrogID provides an unprecedented large-scale snapshot of Australian frog biodiversity, making it invaluable for long-term monitoring and conservation planning.  

---
## Conclusion
The FrogID project represents a landmark achievement in citizen science and biodiversity research in Australia. With nearly one million validated frog call records covering over 88% of Australia's known frog species, FrogID is the largest and most comprehensive dataset available to track the distribution, abundance, and trends of frogs across the continent.

Key insights from this analysis include the identification of biodiversity hotspots concentrated in wetter coastal and temperate regions, along with the prominent role of certain genera such as *Crinia* and *Litoria* in the dataset. The significant contribution from a core group of dedicated citizen scientists underscores the power of community engagement in ecological monitoring.

However, important limitations persist, such as uneven geographic sampling and variability in species detectability. These biases require careful consideration when interpreting results and highlight the continued need for targeted sampling and methodological refinement.

Overall, FrogID provides a crucial foundation for conservation planning, enabling early detection of population declines, assessment of environmental impacts, and more informed management of Australia's unique amphibian fauna. Continued support for citizen science and integration with professional research will be essential to safeguard Australia's frogs amid ongoing environmental challenges.

---
## Contact   
- 📧 [Email](mailto:67912775+FabienHaury@users.noreply.github.com)  
- 💼 [LinkedIn](https://www.linkedin.com/in/fabienhaury/)


