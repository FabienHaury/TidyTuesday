Temporary text holder

<div align="center">

# Agricultural Production Statistics in New Zealand

</div>

## Table of Contents
- [Introduction and Problem Statement](#introduction-and-problem-statement)
- [Methodologies](#methodologies)
- [Data](#data)
- [Visualization](#visualization)
- [Tools](#tools)
- [Contact](#contact)

---

## Introduction and Problem Statement

The world of data is an ever-growing field. Covering the full spectrum from gathering and cleaning data to analysis, one aspect is often overlooked: **data visualization**.  
Even the most thorough analysis can lose its impact if the results are not communicated clearly.  

This project aims to strengthen my data visualization skills by creating visuals that are not only aesthetically appealing but also enhance understanding and deliver clearer insights.

---

## Related analyses

A complementary analysis using the same dataset focuses on cereal crops (wheat, barley, etc.) and total farm area in New Zealand. This analysis will be available soon. <img src="https://img.shields.io/badge/Status-Coming%20soon-orange?style=flat" alt="Status Coming soon" width="90" />

---
## Methodologies

The main goal of this project is not to answer a specific research question but to **develop effective and insightful graphics**.  
The *Methodologies* section will be expanded in the [Visualization](#visualization) part, describing the reasoning and design choices behind each visualization.


---

## Data

“New Zealand’s economy historically relied heavily on agriculture, particularly sheep farming. This dataset tracks herd sizes across decades, offering a window into how agricultural practices and market demands evolved.”

Dataset: [TidyTuesday 2026-02-17](https://github.com/rfordatascience/tidytuesday/blob/main/data/2026/2026-02-17/readme.md)  
A full explanation of each dataset column is available at the link above.  


---

## Visualization
  

### Evolution of sheep population
![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20visualization/Agricultural%20Production%20Statistics%20in%20New%20Zealand/Plots/Graphics/graph_total_sheep.png)   

- Problematic: how to show multiple informations at the same time but without cluttering the graphic.
  - Showing the sheep population for every year to see the evolution of the population.
  - Showing the average population for each decade.
  - Combining those two points in a readable and pleasing way.

- How the graphic is build:
  - First, data are filtered to only keep the revelant data about sheep numbers.
  - If some year are missing then the missing year are added to keep the yearly continuity.
  - Horizontal segment representing each decades are drawn.
  - Dot for each year representing the total number of sheep.
  - Vertical dashed segment are drawn to help visualise the gap between the average line and the dot representing the total for each year.
  - Adding annotation to explain the missing data.
  - Adding label for each decade to help the reader visualising the decade.
  - Working on the aesthetics to make it pleasant/easy on the reader eyes.
    - Double vertical axis has been added to help readibilty when looking as the most recent year.
    - Axis are broken to give the information that their are not relatate.
    - Each decade has is own color to help visualise quickly each decade.
    - A very light, warm beige background was used to evoke the feel of aged paper and to keep the visualization easy on the eyes.
   
- Area for improvement:
  - Assess whether the current color palette effectively communicates the magnitude and temporal differences in the data, even if the design itself remains cohesive and visually appealing.
  - Add direct labels or annotations highlighting minimum and maximum values to make key fluctuations easier to interpret.
  - Explore small adjustments to decade labeling — such as scaling, contrast, or placement tweaks — to further improve visual balance without changing the current layout logic.




---

## Tools

**Environment:** R (Positron IDE)  

**Libraries Used:**
- `dplyr`, `tidyverse`, `ggplot2` for data manipulation and visualization  
- `tidytuesdayR` for accessing datasets  
- `ggtext` and `patchwork` for graphic customization

---

## Contact

- 📧 [Email](mailto:67912775+FabienHaury@users.noreply.github.com)  
- 💼 [LinkedIn](https://www.linkedin.com/in/fabienhaury/)
