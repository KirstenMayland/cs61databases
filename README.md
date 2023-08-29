## Kirsten Mayland - Database Systems Final Project 
##### Dartmouth CS 61, Prof. Goldstein, Summer 2023

### Overview
- [DESIGN.md](DESIGN.md)
- [IMPLEMENTATION.md](IMPLEMENTATION.md)
- [ANALYSIS.md](ANALYSIS.md)
- [FRONTEND.md](FRONTEND.md)
#### Dataset
The database I am using and analyzing is called "2022 Russia Ukraine War" on Kaggle and is a weekly updated dataset of real Russian war losses (personal and equipment) during the ongoing Russian-Ukrainian war as best as is able to be compiled. The data was downloaded 7/30/2023

For Download:  
[Kraggle page for original csv's](https://www.kaggle.com/datasets/piterfm/2022-ukraine-russian-war?select=russia_losses_equipment_correction.csv)
OR [Modified and Cleaned csv's](modified_csv_rus.zip)

### Installation/Setup Instructions
1) Download the modified and cleaned [csv](modified_csv_rus.zip)'s above
2) Import the csv's into a DBMS (eg. MySQL Workbench's Table Data Import Wizard)
3) Run the sql [setup code](rus_database_setup.sql) on the database to properly format and normalize the data  
##### For frontend:  
4) Download site's code ([index.php](index.php) and [style.css](style.css))
5) Use a webserver (eg. XAMPP) to host the site code and connect to the locally stored database

### Reflections
This was a very fun foray into the world of databases and I gained a lot of knowledge in all aspects of the project, but I would say my greatest takeaway from the project was learning about how frontends and backends connect, as that was always a point of confusion for me. For most of my career, I've worked in backend, so this opportunity to work with them in conjunction was a good step towards a compehensive understanding of how websites work, especially the relationship between PHP, XAMPP, HTML, and JavaScript. The four and a half hours I spent laboring over the connection setup allowed me a level of understanding that I was previously unable to obtain through lectures.

Going forward, I would love to try and implement this frontend onto an actual website instead of just the localhost, as that is still a point of confusion for me that I would like to remedy.
