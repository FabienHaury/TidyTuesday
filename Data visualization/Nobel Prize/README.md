<div align="center">

# Nobel Prize

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

## Methodologies

The main goal of this project is not to answer a specific research question but to **develop effective and insightful graphics**.  
The *Methodologies* section will be expanded in the [Visualization](#visualization) part, describing the reasoning and design choices behind each visualization.

---

## Data

Dataset: [TidyTuesday 2019-05-14](https://github.com/rfordatascience/tidytuesday/tree/main/data/2019/2019-05-14)  
A full explanation of each dataset column is available at the link above.

---

## Visualization

### Gender and Nobel Prizes
![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20visualization/Nobel%20Prize/Plots/Graphics/graph_nobel_prize_timeline.png)   
- The main idea is to show the number of men and women who have won a Nobel Prize.  
  - Points represent the number of prizes won by men and women each year.  
  - Lines connect them to show the difference between the two.  
  - Years without a female laureate were assigned a value of **zero** to maintain continuity.  
    > *Note:* This approach introduces slight visual noise. To reduce clutter, the zero points and lines will be made more translucent.

- The axis is broken to highlight how each scale serves a distinct purpose.  
- Three historical periods are marked:
  - During WWI, prizes continued.  
  - During WWII, there was a three-year interruption.  
  - The introduction of new Nobel categories is also indicated as a reference.

**Title and Subtitle Design:**
- **Title:**  
  - *A century-long dive into Nobel Prizes* → indicates the timeframe and adds a vertical reading metaphor.  
- **Subtitle:**  
  - Describes what’s shown — the number of Nobel Prize winners.  
  - The words **men** and **women** replace a legend, each in their respective colors.

**Areas for improvement:**
- Make the zero-value points more translucent to emphasize actual data.  
- Add one more annotation to strengthen context.  
- Consider adding vertical lines showing average prizes per decade, for both men and women.  
- Consider differentiating individual vs. group prizes.

---

### Recreating *The Economist* Style
![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20visualization/Nobel%20Prize/Plots/Graphics/graph_nw_country.png)  
This visualization recreates the sleek style of [The Economist graphic](https://www.economist.com/cdn-cgi/image/width=834,quality=80,format=auto/sites/default/files/images/2021/08/articles/main/20210828_woc034.png).

**Design Elements:**
- A red line with a small rectangle in the upper-left corner.  
- Left-aligned text for consistency.  
- X-axis placed at the top.  
- Labels inside bars when possible; otherwise, outside with small white boxes breaking grid lines.  

**Adjustments made:**
- Numbers of Nobel Prizes are shown inside bars for precision.  
- *Noto Sans* replaces The Economist’s proprietary typeface.  
- Spacing and margins were visually adjusted to match the original style.

---

### Country-by-Category Waffle Chart
![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20visualization/Nobel%20Prize/Plots/Graphics/graph_waffle_top5_category.png)   
Inspired by [R Graph Gallery’s waffle chart example](https://r-graph-gallery.com/web-waffle-chart-for-distribution.html).

**Design Goal:**
Show the **top five most decorated countries** for each Nobel Prize category.

**Key choices:**
- Waffle chart structure highlights relative distribution.  
- Categories arranged alphabetically.  
- Stacking follows a bottom-to-top order (most to least decorated).  
- A concise, engaging title improves readability.  

**Areas for improvement:**
- Replace squares with a medal or award icon to reinforce meaning.  
- Refine the legend placement for better usability.

---

## Tools

**Environment:** R (Positron IDE)  

**Libraries Used:**
- `dplyr`, `tidyverse`, `ggplot2` for data manipulation and visualization  
- `tidytuesdayR` for accessing datasets  
- `ggtext`, `patchwork`, `shadowtext`, `grid`, and `waffle` for graphic customization

---

## Contact

- 📧 [Email](mailto:67912775+FabienHaury@users.noreply.github.com)  
- 💼 [LinkedIn](https://www.linkedin.com/in/fabienhaury/)
