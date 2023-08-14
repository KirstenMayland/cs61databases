## Database Design
#### Tables:
t1: rus_war_timeline  
day (PK)  
date  

t2: equip_loss 
day (PK/FK)  
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
greatest losses loc (char(100))  

t3: people_loss
day (PK/FK)  
personnel (int)  
personnel_about (char(10))  
POW (int)  

excluded:
~~mobile SRBM system~~

Photo of ERD:  
<img width="356" alt="image" src="https://github.com/KirstenMayland/cs61databases/assets/102620915/228481bf-d34e-4135-abc5-35927b75fedf">

Download ERD:  
Click on file "Russia_losses_model.mwb" in repo

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
4) delete corrections table after
5) delete 'mobile SRBM system' attribute (not enough data to be useful)
6) add together 'military auto' and 'fuel tank' columns, merge that data into the blank beginning spots in 'vehicles and fuel tanks' (should match up)
7) delete 'military auto' and 'fuel tank' columns, so there should just be 1 column ('vehicles and fuel tanks') containing all the data of the previous 3  
5) create 'losses' and 'v_and_ft_analysis' tables and move data there
6) change 'russia_losses_equipment' to 'equipment' and russia_losses_personnel to 'personnel'
7) done!/proceed to analysis