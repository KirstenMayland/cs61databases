## Kirsten Mayland
## CS 61 Dartmouth - Database Systems, Prof. Goldstein
final project for databases class

## Process
#### Dataset
The database I am using and analyzing is called "2022 Russia Ukraine War" on Kaggle and is a weekly updated dataset of real Russian war losses (personal and equipment) during the ongoing Russian-Ukrainian war as best as is able to be compiled. The data was downloaded 7/30/2023

[Kraggle Page For Dataset Download](https://www.kaggle.com/datasets/piterfm/2022-ukraine-russian-war?select=russia_losses_equipment_correction.csv)

The dataset can also be found in the zip file, "archive.zip".

#### Example Questions
1) Is there a correlation between POW's taken and losses of aircrafts, helicopters, or tanks?
2) Does the amount of personal loss sustained vary with the seasons e.g. summer more losses than winter?
3) Which day in the war so far has resulted in the greatest loss in Russian lives?
4) Did the type of equipment taking the most losses change from the first month to this last month?

## Database Design
#### Tables:
t1: main  
day (PK)  
date  

t2: equipment  
day (FK)  
aircraft (int)  
helicopter (int)  
tank (int)  
APC (int)  
field artillery (int)  
MRL (int)  
drone (int)  
naval ship (int)  
anti-aircraft warfare (int)  
special equipment (int)  
cruise missiles (int)  
vehicles and fuel tanks (int)  
 - ~~military auto (int) + fuel tank (int)~~  

t4: v_and_ft_analysis  
day (PK/FK)   
greatest losses direction (char(100))  

t3: people  
day (PK/FK)  
personnel (int)  
personnel_about (char(10))  
POW (int)  

excluded:
~~mobile SRBM system~~

#### Notes:
- data is cumulative, so need to take the difference to see day to day changes
- POW: untracked since 2022-04-28
- 'Military Auto' & 'Fuel Tank' were combined into 'Vehicles and Fuel Tanks' as of 2022-05-01
    - but also, under 'Vehicles and Fuel Tanks' it says cruise missiles?
- 'Cruise Missiles': appear 2022-05-01
- 'Direction of Greatest Losses': appears 2022-04-25, sporatic data
- 'Special Equipment' appears to have been recently untracked but still has data for majority (96%) of days
- 'mobile SRBM system': minimal data, only 4 recorded

#### Build Plan:
1) Create schema
2) Import 3 csv tables
3) alter russia_losses_equipment table to accommodate corrections from the corrections table
  >> i) delete corrections table after
4) add together 'military auto' and 'fuel tank' columns, add that data to the blank beginning spots in 'vehicles and fuel tanks' (should match up)
  >> i) delete 'military auto' and 'fuel tank' columns, so there should just be 1 column containing all the data of the previous 3
5) create 'main' and 'v_and_ft_analysis' tables and move data there
