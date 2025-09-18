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
- Cleaning the **available_globally?** column, as some lines incorrectly contain the value `available_globally?`
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
   | 2–30              | Ultra-Short   |
   | 31–120            | Very short    |
   | 121–300           | Short         |
   | 301–720           | Standard      |
   | 721–1440          | Long          |
   | 1441–3600         | Very Long     |
   | 3601–7200         | Epic          |
   | 7201–14400        | Marathon      |
   | 14401+            | Megaseries    |

   
---

## Analysis
To improve clarity, the analysis is split into two parts: movies and shows.

### Movies
![](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/What%20have%20we%20been%20watching%20on%20Netflix%3F/Plots/Graphics/graph_movies_hours.png)  

- The **average viewing time** fluctuates between *2.7M* and *3.0M* across all periods.  
- Do Netflix customers prefer longer movies? The data suggests **yes**. Movies under *150 minutes* consistently fall below the average viewing time, while longer movies generally accumulate more hours watched.  
- The **outlier category** (duration > *180 minutes*) grew from being the third most-watched to becoming the clear leader, peaking at *6.5M* hours watched. A deeper dive could reveal which films belong to this group and why they stand out.  

![](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/What%20have%20we%20been%20watching%20on%20Netflix%3F/Plots/Graphics/graph_movies_views.png)  

- The **average views** remain steady at around *1.5M* across all periods.  
- Surprisingly, the **short category** dominates in terms of views for almost every period except *2025 Jan–Jun*.  
- Similar to viewing hours, the **outlier category** has risen to become one of the most popular lengths.  

**Key points:**  
- The **long category** is the most consistent across all periods, staying above the overall average and maintaining steady numbers.  
- The gap between views and total hours is explained mathematically:  
  - A *40-minute* movie with *3.0M* views equals 120,000,000 minutes watched.  
  - A *180-minute* movie with *1.2M* views equals 216,000,000 minutes watched.  
- This illustrates why short movies can record more **views** but still result in fewer **hours watched** than longer films.  
- A trend toward watching longer movies seems to be emerging, though more data is needed to confirm if this is a lasting pattern or just a short-term spike.  

Now let’s explore which movies topped the charts in each period and check whether they were available globally.  

![](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/What%20have%20we%20been%20watching%20on%20Netflix%3F/Plots/Tables/tab_movies_best_title.png)  

- The first noticeable point is how the **normal** duration category dominates here, which is the opposite of what we observed earlier in terms of viewing hours.  
- Secondly, across **all metrics**, movies released globally perform better. While this is expected since they have a larger audience, the interesting part is that the difference is not enormous—global releases perform roughly **twice as well** as non-global ones, not an order of magnitude higher as one might expect.  

For those interested in a deeper breakdown across multiple metrics for each period, here is a [detailed table](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/What%20have%20we%20been%20watching%20on%20Netflix%3F/Plots/Tables/tab_movies_report_avail_cat.png).  

### Shows

![](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/What%20have%20we%20been%20watching%20on%20Netflix%3F/Plots/Graphics/graph_shows_hours.png)   

- 

![](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/What%20have%20we%20been%20watching%20on%20Netflix%3F/Plots/Graphics/graph_shows_views.png)

-

**Key points:**  
- 
- 
  - 
  - 
- 
- 

Now let’s explore which shows topped the charts in each period and check whether they were available globally. 


![](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/What%20have%20we%20been%20watching%20on%20Netflix%3F/Plots/Tables/tab_shows_best_title.png)   

For those interested in a deeper breakdown across multiple metrics for each period, here is a [detailed table](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/What%20have%20we%20been%20watching%20on%20Netflix%3F/Plots/Tables/tab_shows_report_avail_cat.png).  

---

## Conclusion
<!--
But we do need to keep in mind that the dataset does not always separate movies in th eright number (e.g LoTR movies might be count as one instead of three, which will makes it fall into **outlier** category)
-->
---
## Contact   
- 📧 [Email me](mailto:67912775+FabienHaury@users.noreply.github.com)
- 💼 [Connect on LinkedIn](https://www.linkedin.com/in/fabienhaury/)
