## Database Design

#### ERD:  
<img width="468" alt="image" src="https://github.com/KirstenMayland/cs61databases/assets/102620915/7bf49ec0-fafa-41d2-b706-106d55f6c3b5">

Download ERD:  [Russia_losses_model.mwb](Russia_losses_model.mwb)

#### Tables:
| rus_war_timeline | datatype |
| -----  | ----- |
| day     | int, PK |
| date    | datetime |

| equip_loss | datatype |
| :-----:  | :-----: |
|day  | int, PK/FK |
|aircraft  | int|
|helicopter | int |
|tank  | int|
|APC  | int|
|field artillery  | int|
|MRL  |int|
|drone  | int|
|naval ship  | int|
|anti-aircraft warfare  | int|
|special equipment  | int|
|cruise missiles  | int|
|vehicles and fuel tanks  | int |

| v_and_ft_analysis | datatype |
| :-----: | :-----: |
|day   | int, PK/FK |
|greatest losses loc | text |

| personel_loss  | datatype|
| :-----: | :-----: |
|day  | int, PK/FK |
|personnel  | int|
|personnel_about  | text|
|POW  | int |

excluded from tables once processing is done:  
~~mobile SRBM system~~  
~~military auto (int) + fuel tank (int)~~   

#### Notes:
- data is cumulative, so need to take the difference to see day to day changes
- `POW`: untracked since 2022-04-28
- `Military Auto` & `Fuel Tank` were combined into `Vehicles and Fuel Tanks` as of 2022-05-01
    - but also, under 'Vehicles and Fuel Tanks' it says cruise missiles?
- `Cruise Missiles`: appear 2022-05-01
- `Direction of Greatest Losses`: appears 2022-04-25, sporatic data
- `Special Equipment` appears to have been recently untracked but still has data for majority (96%) of days
- `mobile SRBM system`: minimal data, only 4 recorded

#### Build Plan:
Implementation detailed in [IMPLEMENTATION.md](IMPLEMENTATION.md).
