<div align="center">

# What have we been watching on Netflix?   
*An analysis of Netflix viewership trends*

</div>

## Table of contents
- [Introduction and problematic](#introduction-and-problematic)  
- [Data](#data)  
- [Methodologies](#methodologies)  
- [Analysis](#analysis)  
- [Conclusion](#conclusion)


## Introduction and problematic  
Why study the *Netflix* data?   
1. **Commercial success indicator**   
  *Netflix* charts are a barometer of commercial success. Analyzing viewership and duration can provide insights into what viewers prefer to watch.
2. **Content strategy**    
   Understanding trends helps content creators and platforms tailor their offerings.
And many more reasons! 

### Key questions explored in this report  
- What is the most watch movie or show for each period?
- How distribution of the total hours and views change for differents duration for each period?

---

## Data   
[Data details and dictionary](https://github.com/rfordatascience/tidytuesday/blob/main/data/2025/2025-07-29/readme.md)  
A full explanation of each dataset column is available at the link above.  

---

## Methodologies 
Key columns used include:  
- **report**: Report period, always six month starting from january
- **title**: Title of the movies or the shows
- **available_globally?**: Wether the movie or show is available globally
- **hours_viewed**: Overall total hours spend watching
- **views**: Numbers of views
- **runtime**: Duration of the movie or show. For show it represent the total duration of the show, not of an episode

Data processing includes: 
- Cleaning of **available_globally?** as somes lines contains the value 'available_globally?'
- Converting **runtime** into **runtime_minutes**, a more suitable format for use
- Using the new **runtime_minutes** column for creating **runtime_category** that categorise title by duration into different categories with the intend of allowing better insights
- Removing some **title** in the movies dataset who are show, using a simple search on thoses keywords: "Season", "Series", "Limited Series"

### Categories:
1. movies dataset:     
   - **runtime_minutes** < 40 → short
   - **runtime_minutes** < 75 → short feature
   - **runtime_minutes** <= 120 → normal
   - **runtime_minutes** <= 150 → long
   - **runtime_minutes** <= 180 → very long
   - **runtime_minutes** > 180 → outlier
  
 2. shows dataset:
  - **runtime_minutes** >= 2 & **runtime_minutes** <= 30 → Ultra-Short
  - **runtime_minutes** >= 31 & **runtime_minutes** <= 120 → Very short
  - **runtime_minutes** >= 121 & **runtime_minutes** <= 300 → Short
  - **runtime_minutes** >= 301 & **runtime_minutes** <= 720 → Standard
  - **runtime_minutes** >= 721 & **runtime_minutes** <= 1440 → "Long
  - **runtime_minutes** >= 1441 & **runtime_minutes** <= 3600 → Very Long
  - **runtime_minutes** >= 3601 & **runtime_minutes** <= 7200 → Epic
  - **runtime_minutes** >= 7201 & **runtime_minutes** <= 14400 → Marathon
  - **runtime_minutes** >= 14401 & **runtime_minutes** <= 23853 → Megaseries
---

## Analysis

---

## Conclusion

---
## Contact   
- 📧 [Email](mailto:67912775+FabienHaury@users.noreply.github.com)  
- 💼 [LinkedIn](https://www.linkedin.com/in/fabienhaury/)
