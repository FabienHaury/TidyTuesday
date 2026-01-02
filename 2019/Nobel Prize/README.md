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
The world of data is an ever-growing field. Covering the full spectrum from gathering and cleaning data to analysis, one aspect is often overlooked: data visualization.  
Even the most thorough analysis can lose its impact if the results are not communicated clearly.  
This project aims to strengthen my data visualization skills by creating visuals that are not only aesthetically appealing but also improve understanding and support clearer insights.

---

## Methodologies  
The main goal of this project is not to focus on answering specific questions, but rather on developing effective and insightful graphics.  
The *Methodologies* section will be expanded in the [Visualization](#visualization) part, where I describe the reasoning and design choices behind each visualization.

---

## Data  

Data from Tidytuesday 2019-05-14.
[Data details and dictionary](https://github.com/rfordatascience/tidytuesday/tree/main/data/2019/2019-05-14)  
A full explanation of each dataset column is available at the link above.

---

## Visualization

![](https://github.com/FabienHaury/TidyTuesday/blob/main/2019/Nobel%20Prize/Plots/Graphics/graph_nobel_prize_timeline.png)   
- The main idea is to show the number of men and women who have won a Nobel Prize.  
  - Points represent the number of prizes won by men and women each year, and lines connecting them show the difference between the two.  
  - A challenge appears because not every year had a female laureate, leaving gaps in comparison. To maintain visual continuity, those years were assigned a value of zero.  
    - *Note:* This approach introduces some visual noise, so clarity and balance were prioritized in the design.  
- Breaking the axis—rather than starting at zero—highlights that each scale serves a different purpose.  
- Three key historical periods were marked to provide context:  
  - During World War I, prizes continued, whereas World War II led to a three-year interruption.  
  - The introduction of a new Nobel category is also indicated as a reference point.  
- Title and subtitle guide the reader through the main message:  
  - **Title:**  
    - *A century-long* indicates the dataset’s time span.  
    - *Dive* suggests vertical reading and adds a subtle play on words.  
    - ***Nobel Prizes*** clearly defines the subject.  
  - **Subtitle:**  
    - Describes what is shown — the number of Nobel Prize winners.  
    - The words ***men*** and ***women*** replace a legend, each written in their respective line colors.

      
![](https://github.com/FabienHaury/TidyTuesday/blob/main/2019/Nobel%20Prize/Plots/Graphics/graph_nw_country.png)  
- The goal was to recreate the overall aesthetics from the following [graphic](https://www.economist.com/cdn-cgi/image/width=834,quality=80,format=auto/sites/default/files/images/2021/08/articles/main/20210828_woc034.png).
- Key elements to do:
     - A red line with a small rectangle in the upper-left corner.  
     - Left-aligned text for consistency.  
     - X-axis positioned at the top.  
     - Labels placed inside their bars when possible; otherwise, shown outside with small boxes breaking vertical grid lines.  
- Some adjustments were made: 
     - Numbers of Nobel Prizes are shown inside bars for precision.  
     - *Noto Sans* font replaces The Economist’s proprietary one. 
     - Spacing and margins were estimated to visually match the original.
   
![](https://github.com/FabienHaury/TidyTuesday/blob/main/2019/Nobel%20Prize/Plots/Graphics/graph_waffle_top5_category.png)    
- The goal was to recreate the overall aesthetics of the following [graphic](https://r-graph-gallery.com/web-waffle-chart-for-distribution.html).
- Key elements to do:
        - Using a waffle chart type.
- The top five most decorated countries for each Nobel Prize category are shown.
     - *Note:* this approach help showing that some country might be one of the most decorated in one field but not the others, demonstrating the excellence of that country in that field.
     - The stacking is done from bottom to top with the most decorated country on the bottom and the least one on the top.
     - Prize category are arranged in alphabetical order.
     - A concise, engaging title was added to enhance readability and interest.

---

## Tools
- **Environment**: R, Positron IDE.
- **Libraries**:
  - `dplyr`,`tidyverse` and `ggplot2` for data manipulation and visualization.
  - `tidytuesdayR` for accessing TidyTuesday datasets.
  - `ggtext`, `patchwork`, `shadowtext`, `grid` and `waffle` for advanced graphic customization.

---

## Contact   
- 📧 [Email](mailto:67912775+FabienHaury@users.noreply.github.com)  
- 💼 [LinkedIn](https://www.linkedin.com/in/fabienhaury/)
