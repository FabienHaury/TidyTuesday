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
- [Contact](#contact)

---

## Introduction and problematic
Why study the *Netflix* data?
1. **Commercial success indicator**
   *Netflix* charts are a barometer of commercial success. Analyzing viewership and duration can provide insights into what viewers prefer to watch.
2. **Content strategy**
   Understanding trends helps content creators and platforms tailor their offerings.

### Key questions explored in this report
- What is the most **watched** movie or show for each period?
- How does the distribution of total hours and views change for different durations in each period?

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
![Graph: Movies by Hours Watched](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/What%20have%20we%20been%20watching%20on%20Netflix%3F/Plots/Graphics/graph_movies_hours.png)
- The **average viewing time** fluctuates between *2.7 million* and *3.0 million* hours across all periods.
- Do Netflix customers prefer longer movies? The data suggests **so**. Movies under *150 minutes* consistently fall below the average viewing time, while longer movies generally accumulate more hours watched.
- The **outlier category** (duration > *180 minutes*) grew from being the third most-watched to becoming the clear leader, peaking at *6.5 million* hours watched. A deeper dive could reveal which films belong to this group and why they stand out.

![Graph: Movies by Views](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/What%20have%20we%20been%20watching%20on%20Netflix%3F/Plots/Graphics/graph_movies_views.png)
- The **average views** remain steady at around *1.5 million* across all periods.
- Surprisingly, the **short category** dominates in terms of views for almost every period except *January–June 2025*.
- Similar to viewing hours, the **outlier category** has risen to become one of the most popular lengths.

**Key Points:**
- The **long category** is the most consistent across all periods, staying above the overall average and maintaining steady numbers.
- The gap between views and total hours is explained mathematically:
  - A *40-minute* movie with *3.0 million* views equals *120 million* minutes watched.
  - A *180-minute* movie with *1.2 million* views equals *216 million* minutes watched.
- This illustrates why short movies can record more **views** but still result in fewer **hours watched** than longer films.
- A trend toward watching longer movies seems to be emerging, though more data is needed to confirm if this is a lasting pattern.

Now let’s explore which movies topped the charts in each period and check whether they were available globally.

![Table: Top Movies by Period](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/What%20have%20we%20been%20watching%20on%20Netflix%3F/Plots/Tables/tab_movies_best_title.png)
- The **normal** duration category dominates here, which contrasts with the earlier observation about viewing hours.
- Across **all metrics**, movies released globally perform better. While expected, the difference is not enormous—global releases perform roughly **twice as well** as non-global ones.

For a deeper breakdown, see the **[detailed table for movies](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/What%20have%20we%20been%20watching%20on%20Netflix%3F/Plots/Tables/tab_movies_report_avail_cat.png)**.

---

### Shows
![Graph: Shows by Hours Watched](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/What%20have%20we%20been%20watching%20on%20Netflix%3F/Plots/Graphics/graph_shows_hours.png)
- The **average viewing time** fluctuates between *9.4 million* and *9.7 million* hours across all periods.
- As expected for shows, the longer the runtime, the more hours are spent viewing. The **three biggest categories**—**Epic**, **Marathon**, and **Megaseries**—dominate the charts.

![Graph: Shows by Views](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/What%20have%20we%20been%20watching%20on%20Netflix%3F/Plots/Graphics/graph_shows_views.png)
- The **average views** remain steady at around *1.4 million* across all periods.
- Surprisingly, the **ultra-short category** dominates in terms of views for every period.

**Key Points:**
- The **three longest categories** accumulate the most hours watched but not the most views.
  - Views for these categories may be missing data from earlier periods if they had previous seasons before *June–December 2023*.
  - The number of views may also reflect the fact that starting a show with over *14,000 minutes* (or *233 hours*) discourages viewers due to the fear of burnout.
- Shorter shows may be more appealing due to their **lower time commitment**.

Now let’s explore which shows topped the charts in each period and check whether they were available globally.

![Table: Top Shows by Period](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/What%20have%20we%20been%20watching%20on%20Netflix%3F/Plots/Tables/tab_shows_best_title.png)
- Shows running for *2 to 12 hours* (a season) are the ones hitting the top charts, suggesting this is the sweet spot in terms of duration.
- As expected, shows released globally perform better in every metric.

For a deeper breakdown, see the **[detailed table for shows](https://github.com/FabienHaury/TidyTuesday/blob/main/2025/What%20have%20we%20been%20watching%20on%20Netflix%3F/Plots/Tables/tab_shows_report_avail_cat.png)**.

---

## Conclusion
- It’s important to note that the dataset may not always separate movies or shows correctly (e.g., the *Lord of the Rings* trilogy might be counted as a single entry, placing it incorrectly in the **outlier** category).
- High hours watched does not imply high view numbers; they tend to be negatively correlated.
- Since the study period is relatively short, we cannot draw definitive conclusions about trends. Further analysis would require either historical data or data from future periods.

---

## Contact
- 📧 [Email me](mailto:67912775+FabienHaury@users.noreply.github.com)
- 💼 [Connect on LinkedIn](https://www.linkedin.com/in/fabienhaury/)
