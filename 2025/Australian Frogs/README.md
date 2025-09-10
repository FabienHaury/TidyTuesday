<div align="center">

# Australian Frogs

</div>

## Table of Contents
- [Introduction and Problematic](#introduction-and-problematic)  
- [Data](#data)  
- [Methodologies](#methodologies)

---

## Introduction and Problematic

Why study the *FrogID* dataset?  
1. **Biodiversity and conservation insights**  
   FrogID offers a nationwide view of frog populations, helping track species diversity and declines across Australia.  
2. **Climate and environmental monitoring**  
   Frogs are sensitive indicators of environmental changes (e.g., droughts, habitat loss, disease). Their calls reveal how ecosystems respond to threats.  
3. **Citizen science at scale**  
   Tens of thousands of recordings from the public allow large-scale studies otherwise impossible for a single research team.  

Challenges?  
- Uneven sampling (when & where people record) can bias the data.  
- Varied species detectability complicates comparisons.  

This analysis explores what patterns emerge—and what we can and can’t learn—from this unique ecological resource.

### Key questions explored in this report
  - What is the geographical distribution area of frog observations?  
  - Who are the observers?  
    - Which genus do observers report most frequently?  
    - During which time periods are most observations recorded? 

---

## Data  
[Data details and dictionary](https://github.com/rfordatascience/tidytuesday/blob/main/data/2025/2025-09-02/readme.md)  
A full explanation of each dataset column is available at the link above.  


---

## Methodologies  
Key columns used include: 
 - **recordedBy**: Observer ID.
 - **scientificName**: Scientific frog name.
 - **genus**: Genus type.
 - **specie**: Species type.
 - **stateProvince**: Autralian state.
 - **evenTime**: Time recorded for an event.
 - **decimaleLongitude**: Longitudinal coordinate.
 - **decimalLatitude**: Latitude coordinate.

Data processing include:
  - Splitting `scientificName` into `genus` and `specie` columns.
  - Changing type to integer for `occurrenceID`, `eventID`, `recordedBy`

---

## Analysis
