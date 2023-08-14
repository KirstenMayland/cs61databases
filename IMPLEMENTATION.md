## Implementation

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
