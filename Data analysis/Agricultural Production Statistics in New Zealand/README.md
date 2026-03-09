<div align="center">

# Agricultural Production Statistics in New Zealand <img src="https://img.shields.io/badge/Status-In%20progress-blue?style=flat" alt="Status In progress" width="80" />

</div>

## Table of Contents
- [Introduction and Problem Statement](#introduction-and-problem-statement)
- [Related data visualisation](#related-data-visualisation)
- [Methodologies](#methodologies)
- [Data](#data)
- [Analysis](#analysis)
- [Tools](#tools)
- [Contact](#contact)

---

## Introduction and Problem Statement

The world of data is an ever-growing field. Covering the full spectrum from gathering and cleaning data to analysis, one aspect is often overlooked: **data visualization**.  
Even the most thorough analysis can lose its impact if the results are not communicated clearly.  

This project aims to strengthen my data visualization skills by creating visuals that are not only aesthetically appealing but also enhance understanding and deliver clearer insights.

---

## Related data visualisation

A complementary data visualisation using the same dataset focusing at the total number of sheep in New-Zealand. This data visualisation is available [here](https://github.com/FabienHaury/TidyTuesday/tree/main/Data%20visualization/Agricultural%20Production%20Statistics%20in%20New%20Zealand). <img src="https://img.shields.io/badge/Status-In%20progress-blue?style=flat" alt="Status In progress" width="80" />

---
## Methodologies



---

## Data

“New Zealand’s economy historically relied heavily on agriculture, particularly sheep farming. This dataset tracks herd sizes across decades, offering a window into how agricultural practices and market demands evolved.”

Dataset: [TidyTuesday 2026-02-17](https://github.com/rfordatascience/tidytuesday/blob/main/data/2026/2026-02-17/readme.md)  
A full explanation of each dataset column is available at the link above.  


---

## Analysis
### 1-Evolution of surfaces used for farming
![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Agricultural%20Production%20Statistics%20in%20New%20Zealand/Plots/Graphics/graph_farm_area.png)

|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|1935|Year|
|Ending year|2024|Year|
|↳ Missing year|1997->2001|Year|
|Min surface|13 144 922|Hectares|
|↳ Min year|1956|Year|
|Max surface|21 376 819|Hectares|
|↳ Max year|2012|Year|

### 2-Evolution of crops

#### 2.1-Wheat

![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Agricultural%20Production%20Statistics%20in%20New%20Zealand/Plots/Graphics/graph_crops_wheat.png)

#### Yield
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|1935|Year|
|Ending year|2024|Year|
|↳ Missing year|1997->2001|Year|
|Min yield|72 350|Tonnes|
|↳ Min year|1956|Year|
|Max yield|488 614|Tonnes|
|↳ Max year|2012|Year|

#### Sown
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|1935|Year|
|Ending year|2002|Year|
|↳ Missing year|1997-1998-2000-2001|Year|
|Min sown|26 605|Hectares|
|↳ Min year|1957|Year|
|Max sown|129 975|Hectares|
|↳ Max year|1969|Year|

#### Harvest
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|2003|Year|
|Ending year|2024|Year|
|Min harvested|37 962|Hectares|
|↳ Min year|2006|Year|
|Max harvested|54 762|Hectares|
|↳ Max year|2010|Year|



#### 2.2-Barley

![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Agricultural%20Production%20Statistics%20in%20New%20Zealand/Plots/Graphics/graph_crops_barley.png)

#### Yield
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|1935|Year|
|Ending year|2024|Year|
|↳ Missing year|1997->2001|Year|
|Min yield|10 993|Tonnes|
|↳ Min year|1935|Year|
|Max yield|644 369|Tonnes|
|↳ Max year|1985|Year|

#### Sown
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|1954|Year|
|Ending year|2002|Year|
|↳ Missing year|1997-1998-2000-2001|Year|
|Min sown|16 865|Hectares|
|↳ Min year|1955|Year|
|Max sown|152 332|Hectares|
|↳ Max year|1985|Year|

#### Harvest
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|2003|Year|
|Ending year|2024|Year|

|Min harvested|41 967|Hectares|
|↳ Min year|2017|Year|
|Max harvested|77 669|Hectares|
|↳ Max year|2009|Year|



#### 2.3-Maize

![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Agricultural%20Production%20Statistics%20in%20New%20Zealand/Plots/Graphics/graph_crops_maize.png)

#### Yield
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|1935|Year|
|Ending year|2024|Year|
|↳ Missing year|1956-1997->2001|Year|
|Min yield|5128|Tonnes|
|↳ Min year|1955|Year|
|Max yield|244444|Tonnes|
|↳ Max year|2024|Year|

#### Sown
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|1957|Year|
|Ending year|2002|Year|
|↳ Missing year|1997->2001|Year|
|Min sown|2 220|Hectares|
|↳ Min year|1957|Year|
|Max sown|28 566|Hectares|
|↳ Max year|1977|Year|


#### 2.4-Oats

![](https://github.com/FabienHaury/TidyTuesday/blob/main/Data%20analysis/Agricultural%20Production%20Statistics%20in%20New%20Zealand/Plots/Graphics/graph_crops_oats.png)

#### Yield
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|1935|Year|
|Ending year|2024|Year|
|↳ Missing year|1997->2001-2016|Year|
|Min yield|17 153|Tonnes|
|↳ Min year|1954|Year|
|Max yield|79 677|Tonnes|
|↳ Max year|1983|Year|

#### Sown
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|1954|Year|
|Ending year|2002|Year|
|↳ Missing year|1997->2001|Year|
|Min sown|7 353|Hectares|
|↳ Min year|2022|Year|
|Max sown|22 863|Hectares|
|↳ Max year|1957|Year|



### 3-Evolution of living stocks
#### 3.1-Cattle
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|1971|Year|
|Ending year|1999|Year|
|↳ Missing year|1991-1997-1998|Year|
|Min|7 630 482|Number of animals|
|↳ Min year|1983|Year|
|Max|9 311 000|Number of animals|
|↳ Max year|1974|Year|

#### 3.2-Pigs
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|1971|Year|
|Ending year|2024|Year|
|↳ Missing year|1997-1998-2000-2001|Year|
|Min number|234 533|Number of animals|
|↳ Min year|2020|Year|
|Max number|552 000|Number of animals|
|↳ Max year|1971|Year|

#### 3.3-Sheeps
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|1935|Year|
|Ending year|2024|Year|
|↳ Missing year|1997-1998-2000-2001|Year|
|Min|23 583 001|Number of animals|
|↳ Min year|2024|Year|
|Max|70 301 461|Hectares|
|↳ Max year|1982|Year|

#### 3.4-Goats
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|1978|Year|
|Ending year|2022|Year|
|↳ Missing year|1995-1997-1998-2000-2001-2005-2018-2020-2021|Year|
|Min number|28 192|Hectares|
|↳ Min year|1978|Year|
|Max number|1 300 680|Number of animals|
|↳ Max year|1988|Year|

#### 3.5-Deers
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|1979|Year|
|Ending year|2024|Year|
|↳ Missing year|1997-1998-2000-2001|Year|
|Min|42 080|Number of animals|
|↳ Min year|1979|Year|
|Max|1 756 888|Number of animals|
|↳ Max year|2004|Year|

#### 3.6-Poultry
|Statistic |Value |Units|
|----- |----- |-----|
|Starting year|2002|Year|
|Ending year|2024|Year|
|Min|17 504 212|Number of animals|
|↳ Min year|2006|Year|
|Max|25 675 426|Number of animals|
|↳ Max year|2021|Year|


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
