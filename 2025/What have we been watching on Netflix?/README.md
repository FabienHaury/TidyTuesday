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
- **report**: Report period, always six months starting from January
- **title**: Title of the movie or show
- **available_globally?**: Whether the movie or show is available globally
- **hours_viewed**: Overall total hours spent watching
- **views**: Number of views
- **runtime**: Duration of the movie or show. For shows, this represents the total duration of the series, not an individual episode.

### Data Processing
- Cleaning the **available_globally?** column, as some lines incorrectly contain the value `'available_globally?'`
- Converting **runtime** (e.g., "2h 15m") into **runtime_minutes** (e.g., 135 minutes) for easier analysis
- Creating a **runtime_category** column to categorize titles by duration, allowing for better insights
- Removing show titles from the movies dataset using keyword searches for "Season," "Series," and "Limited Series"

### Categories:
1. **Movies dataset:**
   | Runtime (minutes) | Category      |
   |-------------------|---------------|
   | < 40              | Short         |
   | 40–74             | Short feature |
   | 75–120            | Normal        |
   | 121–150           | Long          |
   | 151–180           | Very long     |
   | > 180             | Outlier       |

2. **Shows dataset:**
   | Runtime (minutes) | Category      |
   |-------------------|---------------|
   | 2–30              | Ultra-Short    |
   | 31–120            | Very short    |
   | 121–300           | Short         |
   | 301–720           | Standard      |
   | 721–1440          | Long          |
   | 1441–3600         | Very Long     |
   | 3601–7200         | Epic          |
   | 7201–14400        | Marathon      |
   | 14401–23853       | Megaseries    |

   
---

## Analysis

---

## Conclusion

---
## Contact   
- 📧 [Email me](mailto:67912775+FabienHaury@users.noreply.github.com)
- 💼 [Connect on LinkedIn](https://www.linkedin.com/in/fabienhaury/)
