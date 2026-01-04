<div align="center">

# European energy

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
### Explanation of green VS non-green energy.  
**Green energy** means very low CO₂ and useful for climate goals, wind, solar, nuclear, hydro and geothermal are considered *green* for this project.   
**Non-green energy** means high CO₂ emissions or other pollution and works against climate goals. 

---

## Data

Dataset: [TidyTuesday 2020-08-04](https://github.com/rfordatascience/tidytuesday/blob/main/data/2020/2020-08-04/readme.md)  
A full explanation of each dataset column is available at the link above.  


---

## Visualization
  

### Energy mix by EU country
![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20visualization/European%20energy/Plots/Graphics/graph_energy_comp_country.png)   
This visualization get inspired by the one done by [Karim Douieb](https://camo.githubusercontent.com/1562df2eaf88f6319a0c4b4d78d9e58eb187448d476b098fc0fb6d2316619e4a/68747470733a2f2f7062732e7477696d672e636f6d2f6d656469612f45655653686b6e58304141586273413f666f726d61743d706e67266e616d653d343039367834303936).   

- The main idea was to show the energy production mix for the each country within the European Union.
  - Before starting doing the graphic, a debate arose on how to categorize the energy source. Multiple options have been considered:
    - 1- Grouping energy in three groups, `non-green`, `green` and `renewable energy` as follow :
      |Energy source|Group|
      |------------|------|
      |Conventional thermal|Non-green|
      |Nuclear|Green|
      |Wind|Renewable|
      |Geothermal|Renewable|
      |Solar|Renewable|
      |Hydro|Renewable|
    - 2- Grouping every energy source but `non-green` and `green` as follow:
|Energy source|Group|
      |------------|------|
      |Conventional thermal|Non-green|
      |Nuclear|Green|
      |Wind|Green|
      |Geothermal|Green|
      |Solar|Green|
      |Hydro|Green|
    - 3- Keeping them separate but separating the `non-green` and `green` as shown in the point 2 above in the graph by making the `non-green` negative percentage.
  - The third option is on the use in the graphic, for two main reasons :
    - 1- The zero line acts as a visual divider, clearly showing each country's balance between `non-green` and `green` energy.
    - 2- It highlights how countries follow different paths toward greener energy — some rely more on wind, others on solar or nuclear.
      
**Color palette:**
  - Each energy source is assigned a consistent color to enable quick visual recognition.

**Data organization:**
  - Countries were ordered from the greenest to the least green, immediately showing where each stands on the green–non-green spectrum.

**Title and Subtitle Design:**
- **Title:**  
  - *How green is the EU's energy? A 2018 snapshot of member's state energy mix* → provides timeframe and context in an engaging, question-based form.    
- **Subtitle:**  
  - Describes the total energy production per source and reinforces the *green vs. non-green* distinction.

**Annotations:**
- Key insights are highlighted to guide the viewer’s attention.

**Areas for improvement:**
- Include both the percentage share and total energy production, as seen in the inspiration chart.  
- Improve the legend’s layout and readability.  
- Consider removing negative percentages for `non-green` energy to avoid conceptual confusion. 
- Replace country codes with full names (requires label redesign for readability).
- Optionally add percentage labels inside segments — but only for selected countries to prevent clutter.

---

### Ranking of EU countries by green energy share
![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20visualization/European%20energy/Plots/Graphics/graph_ranking_country.png)  

The objective of this visualization is to show how each EU country's ranking evolved based on its total *green* energy production between 2016 and 2018.  
A change in ranking does not necessarily mean that a country produced more or less energy overall — it may simply reflect differences in the *share* of green energy compared to other countries.
    
**Design choices:**
- Using **country flags** instead of names improves readability and allows quick identification of each country.  
- Displaying **total rank changes** after the last flag — green for a positive change, red for a negative one — provides an immediate sense of movement at a glance.  
- A small **summary box** showing the largest gains and losses helps contextualize how dynamic or stable the rankings are overall.
  
**Areas for improvement:**
- Apply color to the connecting lines themselves (green or red) for countries that changed position, to reinforce the visual link between movement and trend.  
- Add an element that gives the chart more visual impact — for example, emphasizing significant movers with highlighted paths or subtle annotations describing possible reasons for the change.



---

## Tools

**Environment:** R (Positron IDE)  

**Libraries Used:**
- `dplyr`, `tidyverse`, `ggplot2` for data manipulation and visualization  
- `tidytuesdayR` for accessing datasets  
- `ggtext`, `ggbump`, `ggflag` and `grid` for graphic customization

---

## Contact

- 📧 [Email](mailto:67912775+FabienHaury@users.noreply.github.com)  
- 💼 [LinkedIn](https://www.linkedin.com/in/fabienhaury/)
