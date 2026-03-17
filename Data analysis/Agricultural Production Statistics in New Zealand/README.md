<div align="center">

# Agricultural Production Statistics in New Zealand <img src="https://img.shields.io/badge/Status-In%20progress-blue?style=flat" alt="Status In progress" width="80" />

</div>

## Table of Contents
- [Introduction and Problem Statement](#introduction-and-problem-statement)
- [Related data visualisation](#related-data-visualisation)
- [Data](#data)
- [Methodologies](#methodologies)
- [Analysis](#analysis)
- [Notable Events and Policies](#notable-events-and-policies)
- [Tools](#tools)
- [Contact](#contact)

---

## Introduction and Problem Statement
New Zealand’s economy has historically relied on agriculture, but how have farming practices and outputs evolved over the past century? This analysis explores trends in crop yields, livestock numbers, and farmland use, using data from **Stats NZ** (via **TidyTuesday**). We aim to identify key shifts, possible drivers, and implications for policy and sustainability.

Key findings from this analysis:  
1. Total farm area expanded by roughly 25% from the early 1970s, then plateaued for about 15 years before declining to below pre‑expansion levels – a downward trend that continues today.  
2. Sheep numbers closely mirror this pattern, peaking in the early 1980s and declining steadily to their lowest recorded levels in 2024.  
3. Crop production has shifted from land-intensive cereals (wheat, oats, barley) toward higher-yield, more intensive systems (notably maize), indicating a structural move toward productivity over scale.  
4. Livestock composition has diversified: while sheep and pigs have declined, deer and poultry expanded from the late 20th century, reflecting changing markets and farming systems. 

The sections below unpack these patterns in more detail. We first examine how total farm area has changed over time, then explore major crop groups and livestock populations to understand how New Zealand’s agricultural landscape has been reshaped.

### What is *Stats NZ*?
[Stats NZ](https://www.stats.govt.nz/) is New Zealand’s official data agency, employing over 1,000 staff across Auckland, Wellington, Christchurch, and regional offices. They collect and publish data through censuses and surveys, providing insights into New Zealand’s economy, environment, and society.

### Why study the *Stat NZ* dataset?  
1. Understand long-term trends in agricultural production and their economic impact.
2. Identify shifts in farming practices and their environmental implications.
3. Inform policy and sustainability efforts in New Zealand’s agricultural sector.

### Focus of this analysis.
This analysis focuses on two main questions:   
1. How have New Zealand’s agricultural land use, crop areas and yields, and livestock populations changed over the past century?   
2. Which structural breaks in policy or markets coincide with the major turning points in land use and livestock numbers?    

This analysis does not model causality or profitability; it focuses on long‑run descriptive trends derived from Stats NZ agricultural production statistics.
 
### What we can infer: 
   - Long‑run trends and turning points in area and numbers.
   - Sequencing of changes relative to major policy shifts.

### What we cannot infer:
   - Farm‑level profitability or productivity per animal.
   - Environmental pressures (emissions, water quality) directly.
   - Detailed causal attribution (e.g. exactly how much of the sheep decline is due to subsidies vs. global prices vs. forestry conversion).


---

## Related data visualisation

Complementary data visualizations using the same dataset, focusing on sheep numbers and crop culture, are available [here](https://github.com/FabienHaury/TidyTuesday/tree/main/Data%20visualization/Agricultural%20Production%20Statistics%20in%20New%20Zealand). These visualizations are designed to showcase data presentation skills and provide a quick overview of key trends. <img src="https://img.shields.io/badge/Status-In%20progress-blue?style=flat" alt="Status In progress" width="80" />

---

## Data
“New Zealand’s economy historically relied heavily on agriculture, particularly sheep farming. This dataset tracks herd sizes across decades, offering a window into how agricultural practices and market demands evolved.”

Dataset: [TidyTuesday 2026-02-17](https://github.com/rfordatascience/tidytuesday/blob/main/data/2026/2026-02-17/readme.md)  
A full explanation of each dataset column is available at the link above.  

Data limitation:   
1- Several years are missing from the dataset (not consciously avoided).   
2- Around the early 2000s, data collection shifted from recording *sown* to *harvested* crop areas, which may affect trend comparisons.   
3- Not all crops have sown or harvested data.


---

## Methodologies
1. **Data preparation and cleaning**  
   - Created a derived `decade` variable to enable aggregation and comparison of long‑term trends (mainly used in the Data visualisations section).  
   - Wrapped repeated operations (filtering, summarising) into custom R functions to reduce duplication and improve readability (see the referenced [function.R](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Agricultural%20Production%20Statistics%20in%20New%20Zealand/Notebook/function.R) script). For each series (e.g. sheep numbers) the function reports min, max, and associated years, which are then used in the tables below.

2. **Descriptive summarisation**  
   - Implemented a summary function to compute key statistics for each series: start and end years, missing years, minima and maxima (with their years), and units.  
   - Applied this function consistently across crops and livestock so that metrics remain comparable and can feed directly into the tables and comments in the **Analysis** section.

3. **Visualisation design choices**  
   - Fixed the x‑axis to `Year` (1935–2025) for all line charts so different crops and livestock can be compared on a common timeline.  
   - Used free y‑axes that always start at 0 to avoid distorting trends, added numeric suffixes (e.g. thousands, millions) to the axis labels, and specified units (tonnes, hectares, number of animals) in axis title to keep scales interpretable.


---

## Analysis
### 1-Evolution of surfaces used for farming
![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Agricultural%20Production%20Statistics%20in%20New%20Zealand/Plots/Graphics/graph_farm_area.png)

|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|1935|Year|
|Ending year|2024|Year|
|↳ Missing year|1997->2001|Year|
|Min surface|13,144,922|Hectares|
|↳ Min year|1956|Year|
|Max surface|21,376,819|Hectares|
|↳ Max year|2012|Year|

We observe three distinct period:  
   1. 1935 to 1970: The farmland area remained stable at around 17.5 million hectares. This period followed the Ottawa agreements with the UK and Labour’s dairy support policies, which encouraged the conversion of forests and marginal lands into farmland.
   2. 1971 to 1986: There was a rapid expansion in farmland, reaching a peak of about 21 million hectares. This growth coincides with a shift from crops to livestock farming, subsidies for fertilizers and grasslands, and the expansion of the dairy industry—all of which required more land.
   3. 1987 to 2024: A sharp decline occurred in 1987, dropping from 21 million to 17 million hectares. Since then, the total farmland area has continued to decrease. This trend is linked to the Rogernomics reforms (1984–1985), which removed most agricultural subsidies (representing about 40% of farm income), leading to significant changes in land use. More recently, factors such as the conversion of farmland to forestry, urban development, and stricter environmental regulations have further reduced the farmland area.

### 2-Evolution of crops
#### 2.1-Wheat
![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Agricultural%20Production%20Statistics%20in%20New%20Zealand/Plots/Graphics/graph_crops_wheat.png)

#### Yield
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|1935|Year|
|Ending year|2024|Year|
|↳ Missing year|1997->2001|Year|
|Min yield|72,350|Tonnes|
|↳ Min year|1956|Year|
|Max yield|488,614|Tonnes|
|↳ Max year|2012|Year|

#### Sown
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|1935|Year|
|Ending year|2002|Year|
|↳ Missing year|1997-1998-2000-2001|Year|
|Min sown|26,605|Hectares|
|↳ Min year|1957|Year|
|Max sown|129,975|Hectares|
|↳ Max year|1969|Year|

#### Harvest
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|2003|Year|
|Ending year|2024|Year|
|Min harvested|37,962|Hectares|
|↳ Min year|2006|Year|
|Max harvested|54,762|Hectares|
|↳ Max year|2010|Year|

We observe three distinct periods:  
 1. 1935 to 1960: Wheat yields fluctuated substantially from year to year, while the sown area gradually declined from mid‑century, suggesting less land devoted to wheat even before any clear, sustained lift in output.
 2. 1961 to 1990: Yields increased to much higher levels than in the early period and stayed elevated, while the cultivated area was relatively stable or slowly shrinking, hinting at higher output per hectare over time.
 3. 1991 to 2024: Yields frequently reached their highest recorded values even as harvested area remained well below mid‑20th‑century peaks, which could indicate (hypothetically) more intensive production systems or a focus on the most suitable wheat land.

#### 2.2-Barley
![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Agricultural%20Production%20Statistics%20in%20New%20Zealand/Plots/Graphics/graph_crops_barley.png)

#### Yield
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|1935|Year|
|Ending year|2024|Year|
|↳ Missing year|1997->2001|Year|
|Min yield|10,993|Tonnes|
|↳ Min year|1935|Year|
|Max yield|644,369|Tonnes|
|↳ Max year|1985|Year|

#### Sown
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|1954|Year|
|Ending year|2002|Year|
|↳ Missing year|1997-1998-2000-2001|Year|
|Min sown|16,865|Hectares|
|↳ Min year|1955|Year|
|Max sown|152,332|Hectares|
|↳ Max year|1985|Year|

#### Harvest
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|2003|Year|
|Ending year|2024|Year|
|Min harvested|41,967|Hectares|
|↳ Min year|2017|Year|
|Max harvested|77,669|Hectares|
|↳ Max year|2009|Year|

We observe three distinct periods:
 1. 1935–1965: Barley yields rose from very low levels to over 100,000 tonnes, with noticeable year‑to‑year volatility and no area data before the mid‑1950s to show how much was driven by expansion.
 2. 1966–1990: Both yields and sown area climbed sharply, peaking in the mid‑1980s at over 640,000 tonnes and more than 150,000 hectares, before dropping back by 1990.
 3. 1991–2024: Yields stayed relatively high but below the 1980s peak, while sown and then harvested area fell to much lower levels than in the expansion phase, suggesting a smaller but still productive barley sector.


#### 2.3-Maize
![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Agricultural%20Production%20Statistics%20in%20New%20Zealand/Plots/Graphics/graph_crops_maize.png)

#### Yield
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|1935|Year|
|Ending year|2024|Year|
|↳ Missing year|1956-1997->2001|Year|
|Min yield|5,128|Tonnes|
|↳ Min year|1955|Year|
|Max yield|244,444|Tonnes|
|↳ Max year|2024|Year|

#### Sown
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|1957|Year|
|Ending year|2002|Year|
|↳ Missing year|1997->2001|Year|
|Min sown|2,220|Hectares|
|↳ Min year|1957|Year|
|Max sown|28,566|Hectares|
|↳ Max year|1977|Year|

We observe three distinct periods:
 1. 1935–1965: Maize yields remained low and variable, generally below 25,000 tonnes, with sown area data only available from 1957 showing very small plantings (under 4,000 hectares).
 2. 1966–1990: Yields rose sharply from the mid‑1960s, peaking above 200,000 tonnes in the late 1970s, while sown area expanded to a maximum of nearly 29,000 hectares before levelling off.
 3. 1991–2024: Yields stayed high and even reached a record 244,444 tonnes in 2024, but sown area remained much smaller and stable (around 15,000–20,000 hectares), indicating sustained high output from less land.


#### 2.4-Oats
![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Agricultural%20Production%20Statistics%20in%20New%20Zealand/Plots/Graphics/graph_crops_oats.png)

#### Yield
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|1935|Year|
|Ending year|2024|Year|
|↳ Missing year|1997->2001-2016|Year|
|Min yield|17,153|Tonnes|
|↳ Min year|1954|Year|
|Max yield|79,677|Tonnes|
|↳ Max year|1983|Year|

#### Sown
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|1954|Year|
|Ending year|2002|Year|
|↳ Missing year|1997->2001|Year|
|Min sown|7,353|Hectares|
|↳ Min year|2002|Year|
|Max sown|22,863|Hectares|
|↳ Max year|1957|Year|

We observe three distinct periods:
 1. 1935–1965: Oats yields fluctuated widely between 17,000–76,000 tonnes with no clear trend upward or downward, while sown area data from 1954 shows variable plantings peaking near 23,000 hectares in 1957.
 2. 1966–1990: Yields trended higher with several peaks above 70,000 tonnes (notably 1983), while sown area remained variable but generally between 10,000–22,000 hectares without major expansion.
 3. 1991–2024: Yields dropped to consistently lower levels (mostly 20,000–40,000 tonnes), and sown area shrank further to around 7,000–15,000 hectares, indicating a much smaller oats sector overall.



### 3-Evolution of living stocks
#### 3.1-Cattle
![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Agricultural%20Production%20Statistics%20in%20New%20Zealand/Plots/Graphics/graph_stocks_cattle.png)
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|1971|Year|
|Ending year|1999|Year|
|↳ Missing year|1991-1997-1998|Year|
|Min|7,630,482|Number of animals|
|↳ Min year|1983|Year|
|Max|9,311,000|Number of animals|
|↳ Max year|1974|Year|

We observe three distinct periods:
 1. 1971–1979: Cattle numbers grew rapidly from 8 million to a peak of 9.3 million in 1974, then declined slightly to 8 million by decade's end.
 2. 1980–1989: Numbers stabilised around 8 million with a brief recovery to 8.3 million mid-decade, but no return to 1970s highs.
 3. 1990–1999: Numbers fluctuated between 8–9 million despite data gaps, ending near 9 million with no clear upward or downward trend.


#### 3.2-Pigs
![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Agricultural%20Production%20Statistics%20in%20New%20Zealand/Plots/Graphics/graph_stocks_pig.png)
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|1971|Year|
|Ending year|2024|Year|
|↳ Missing year|1997-1998-2000-2001|Year|
|Min number|234,533|Number of animals|
|↳ Min year|2020|Year|
|Max number|552,000|Number of animals|
|↳ Max year|1971|Year|

We observe three distinct periods:
 1. 1971–1980: Pig numbers declined steadily from a peak of 552,000 to around 430,000, showing an early contraction after the decade's high.
 2. 1981–2000: Numbers stabilised around 400,000 with minor fluctuations despite data gaps, maintaining a relatively consistent but smaller herd size.
 3. 2001–2024: Numbers continued downward to a low of 234,533 in 2020 before slight recovery, ending at 243,588—well below 1970s levels with a much reduced pig sector.


#### 3.3-Sheep
![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Agricultural%20Production%20Statistics%20in%20New%20Zealand/Plots/Graphics/graph_stocks_sheep.png)
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|1935|Year|
|Ending year|2024|Year|
|↳ Missing year|1997-1998-2000-2001|Year|
|Min|23,583,001|Number of animals|
|↳ Min year|2024|Year|
|Max|70,301,461|Number of animals|
|↳ Max year|1982|Year|

We observe three distinct periods:
 1. 1935–1979: Sheep numbers grew steadily from ~29 million to nearly 70 million, with consistent expansion through the postwar decades peaking just before 1980.
 2. 1980–1999: Numbers stabilised near 70 million before declining sharply to around 45 million by decade's end, despite data gaps.
 3. 2000–2024: A continued strong decline brought numbers to a record low of 23.6 million, halving from early 2000s levels.


#### 3.4-Goats
![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Agricultural%20Production%20Statistics%20in%20New%20Zealand/Plots/Graphics/graph_stocks_goats.png)
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|1978|Year|
|Ending year|2022|Year|
|↳ Missing year|1995-1997-1998-2000-2001-2005-2018-2020-2021|Year|
|Min number|28,192|Number of animals|
|↳ Min year|1978|Year|
|Max number|1,300,680|Number of animals|
|↳ Max year|1988|Year|

We observe three distinct periods:
 1. 1978–1988: Goat numbers exploded from 28,000 to a peak of 1.3 million, showing dramatic growth over a single decade.
 2. 1989–1999: Numbers declined sharply from over 1 million to around 186,000 despite data gaps, a rapid contraction phase.
 3. 2000–2022: Numbers stabilised at much lower levels (80,000–150,000 range) with ongoing fluctuations but no return to 1980s peaks.


#### 3.5-Deer
![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Agricultural%20Production%20Statistics%20in%20New%20Zealand/Plots/Graphics/graph_stocks_deer.png)
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|1979|Year|
|Ending year|2024|Year|
|↳ Missing year|1997-1998-2000-2001|Year|
|Min|42,080|Number of animals|
|↳ Min year|1979|Year|
|Max|1,756,888|Number of animals|
|↳ Max year|2004|Year|

We observe three distinct periods:
 1. 1979–1999: Deer numbers grew explosively from 42,000 to a peak of 1.68 million, establishing deer farming as a major new agricultural sector.
 2. 2000–2013: Numbers stabilised near 1.6–1.7 million before beginning a gradual decline despite data gaps in the late 1990s.
 3. 2014–2024: Numbers fell steadily to 708,627—a contraction of over 50% from peak levels, though still far above early industry figures.


#### 3.6-Poultry
![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Agricultural%20Production%20Statistics%20in%20New%20Zealand/Plots/Graphics/graph_stocks_poultry.png)
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|2002|Year|
|Ending year|2024|Year|
|Min|17,504,212|Number of animals|
|↳ Min year|2006|Year|
|Max|25,675,426|Number of animals|
|↳ Max year|2021|Year|

We observe three distinct periods:
 1. 2002–2009: Poultry numbers fluctuated around 18–22 million with no clear trend, starting from a high base in the early 2000s.
 2. 2010–2017: Numbers rose steadily from 19 million to nearly 24 million, showing consistent growth through the decade.
 3. 2018–2024: Numbers stabilised near 24–25 million with minor variation, maintaining high levels after the growth phase.

### 4-Synthesis  
#### 4.1 From extensive to intensive agriculture
 -Less land  
 -Higher yields  
 -More output per hectare  

#### 4.2-From sheep dominance to diversification
 -Sheep collapse  
 -Rise of deer + poultry  
 -Stable cattle  

#### 4.3-From policy-driven to market-driven system
 -Pre-1984: expansion via subsidies  
 -Post-1984: efficiency + specialization  

---

## Notable Events and Policies
**Ottawa Deals (1932)**: Empire trade pacts signed at the Ottawa Conference to boost intra-Commonwealth commerce amid the Great Depression; New Zealand gained preferential UK market access for meat, dairy, and wool, fueling pastoral expansion.  

**Rogernomics (1984–85)**: Radical free-market reforms under Finance Minister Roger Douglas; overnight subsidy cuts (40% of farm income), deregulation, and subsidy abolition forced NZ agriculture to restructure, specialize in exports, and become globally competitive.

**Sown Area**: Total land planted/seeded with a crop, regardless of outcome.

**Harvested Area**: Only the portion actually reaped (excludes failures/disasters). **FAO/FAOSTAT international standard** for yield calculations.

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
