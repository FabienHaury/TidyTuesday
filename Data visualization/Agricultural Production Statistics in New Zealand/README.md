<div align="center">

# Agricultural Production Statistics in New Zealand

</div>

## Table of Contents
- [Introduction and Problem Statement](#introduction-and-problem-statement)
- [Methodologies](#methodologies)
- [Data](#data)
- [Visualization](#visualization-breakdown)
- [Tools](#tools)
- [Contact](#contact)

---

## Introduction and Problem Statement

The world of data is an ever-growing field. While data work spans the entire pipeline—from data collection and cleaning to analysis—one aspect is often overlooked: **data visualization**. Even the most thorough analysis can lose its impact if the results are not communicated effectively. 

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

## Visualization Breakdown
  

### Evolution of sheep population
![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20visualization/Agricultural%20Production%20Statistics%20in%20New%20Zealand/Plots/Graphics/graph_total_sheep.png)   


#### Problem
The goal of this visualization was to display multiple layers of information while keeping the graphic readable: 

- yearly sheep population.
- the average population for each decade
- the deviation between individual years and decade averages

#### Data Processing
- Filter the dataset to retain sheep population data
- Reconstruct missing years to maintain a continuous time series
- Compute average population values for each decade
- Create layered visual elements using `ggplot2`

#### Design Choices
To achieve this, the visualization combines several elements:

- **Dots** represent the sheep population for each year.
- **Horizontal segments** indicate the average population for each decade.
- **Vertical dashed lines** highlight the gap between yearly values and the decade average.
- **Decade labels and colors** help the reader quickly identify different time periods.

The background uses a light beige tone to evoke the appearance of aged paper while maintaining good visual readability.
   
#### Possible Improvements
Future iterations of the graphic may include:
- Assess whether the current color palette effectively communicates the magnitude and temporal differences in the data, even if the design itself remains cohesive and visually appealing.
- Add direct labels or annotations highlighting minimum and maximum values to make key fluctuations easier to interpret.
- Explore small adjustments to decade labeling — such as scaling, contrast, or placement — to further improve visual balance without changing the current layout logic.









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
